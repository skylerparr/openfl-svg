package macros;
import haxe.macro.Type.Ref;
import haxe.macro.Type.ClassType;
import haxe.macro.Printer;
import haxe.macro.ExprTools;
import haxe.macro.Context;
import haxe.macro.Expr;
class SVGHelper {
    macro public static function build(args: Expr = null):Array<Field> {
        var skipBounds: Bool = false;
        var skipChild: Bool = false;

        switch(args.expr) {
            case EObjectDecl(opts):
                for(opt in opts) {
                    switch(opt.field) {
                        case "skipChild":
                            skipChild = true;
                        case "skipBounds":
                            skipBounds = true;
                        case _:
                    }
                }
            case _:
        }

        var fields:Array<Field> = Context.getBuildFields();
        var finalFields:Array<Field> = [];
        var assignments:Array<Dynamic> = [];
        var renderFunction: Field = null;
        var hasChildren:Bool = false;

        for (field in fields) {
            switch(field) {
                case {name: name = _, kind: kind = FVar(TPath(tp)), meta: [{name: "prop"}]}:
                    assignments.push({name: name, type: kind});
                    var field:Field = {
                        pos: Context.currentPos(),
                        name: name,
                        access: [APublic],
                        kind: FVar(TPath(tp))
                    }
                    finalFields.push(field);
                case {name: name = "children"}:
                    hasChildren = true;
                    finalFields.push(field);
                case {name: name = "render"}:
                    renderFunction = field;
                    finalFields.push(field);
                case _:
                    finalFields.push(field);
            }
        }
        var e = genAssignAttributes(assignments, hasChildren);

        var assignAttributesField:Field = {
            pos: Context.currentPos(),
            name: "assignAttributes",
            access: [APublic],
            kind: FFun({
                ret: TPath({name: "Void", params: [], pack: []}),
                args: [{name: "element", type: TPath({name: "Xml", params: [], pack: []})}],
                expr: e
            }),
        }
        finalFields.push(assignAttributesField);

        var cloneField: Field = {
            pos: Context.currentPos(),
            name: "clone",
            access: [APublic],
            kind: FFun({
                ret: TPath({name: "SVGElement", params: [], pack: ["svg", "core"]}),
                args: [],
                expr: genClone()
            })
        }
        finalFields.push(cloneField);

        var graphicsField: Field = {
            pos: Context.currentPos(),
            name: "graphics",
            access: [APrivate],
            kind: FVar(TPath({name: "Dynamic", pack: []}), null)
        }
        finalFields.push(graphicsField);

        var trueGraphicsField: Field = {
            pos: Context.currentPos(),
            name: "trueGraphics",
            access: [APrivate],
            kind: FVar(TPath({name: "Dynamic", pack: []}), null)
        }
        finalFields.push(trueGraphicsField);

        var docField: Field = {
            pos: Context.currentPos(),
            name: "doc",
            access: [APublic],
            kind: FVar(TPath({name: "Sprite", pack: ["openfl", "display"]}), null)
        }
        finalFields.push(docField);

        var stylesField: Field = {
            pos: Context.currentPos(),
            name: "styles",
            access: [APublic],
            kind: FVar(TPath({name: "Styles", pack: ["svg", "core"]}), null)
        }
        finalFields.push(stylesField);

        var elementName: String = Context.getLocalClass().get().name;
        elementName = '${elementName.charAt(0).toLowerCase()}${elementName.substring(1)}';

        var nameField: Field = {
            pos: Context.currentPos(),
            name: "name",
            access: [APublic],
            kind: FVar(TPath({name: "String", pack: []}), macro $v{elementName})
        }
        finalFields.push(nameField);

        genRenderCommon(renderFunction, assignments, skipBounds, skipChild);

        return finalFields;
    }

    #if macro
    private static function genRenderCommon(renderFunction: Field, assignments:Array<Dynamic>, skipBounds: Bool, skipChild: Bool):Void {
        var switchStatement: Expr = macro switch (field) {
                case _:{
                    try {
                        if (Reflect.field(this, field) == null) {
                            Reflect.setField(this, field, Reflect.field(inherit, field));
                        }
                    } catch(e:Dynamic) { }
                }
            }
        var cases:Array<Case> = null;

        switch(switchStatement) {
            case {expr: ESwitch({expr: EParenthesis({expr: _})}, c = _, _)}:
                cases = c;
            case _:
        }

        for (assignment in assignments) {
            var c:Case = {values: [{expr: EConst(CString(assignment.name, DoubleQuotes)), pos: Context.currentPos()}]};
            cases.unshift(c);
        }

        var renderBounds = macro null;
        if(!skipBounds) {
            renderBounds = macro {
                trueGraphics.lineStyle(0, 0, 0);
                trueGraphics.beginFill(0, 0);
                trueGraphics.drawRect(0, 0, 10, 10);
                trueGraphics.endFill();
            }
        }

        var renderChild = macro trueGraphics = SVGRender.getGraphics(doc);
        if(!skipChild) {
            renderChild = macro {
                renderSprite = new Sprite();
                doc.addChild(renderSprite);
                trueGraphics = SVGRender.getGraphics(renderSprite);
                doc = renderSprite;
            }
        }

        var pre: Expr = macro {
            if (inherit != null) {
                var fields:Array<String> = Reflect.fields(inherit);
                for (field in fields) {
                    if (Reflect.field(inherit, field) != null) {
                        ${switchStatement}
                    }
                }
            }
            if (id != null && !defs.exists(id)) {
                defs.set(id, this);
            };
            ${renderChild}
            ${renderBounds}
            this.doc = doc;
            doc.name = id;
            if(styles != null) {
                styles.applyTopLevelStyle(this, this.name);
            }
            if(clazz != null) {
                styles.applyClassStyle(this, clazz);
            }

            initialDraw(doc, defs, trueGraphics);
            graphics = trueGraphics;
        }

        var post: Expr = macro {
            postDraw(doc, defs, graphics);
        }

        switch(renderFunction.kind) {
            case FFun({expr: expr = {expr: EBlock(exprs)}}):
                exprs.unshift(pre);
                exprs.push(post);
            case _:
        }
    }

    private static function genClone():Expr {
        var cls: Null<Ref<ClassType>> = Context.getLocalClass();
        var fqcn: String = '${cls.get().pack.join(".")}.${cls.get().name}';
        return macro {
            var cls: Class<Dynamic> = util.ClassUtil.stringToClass($v{fqcn});
            var e: SVGElement = util.ClassUtil.createInstanceFromClass(cls, []);
            var fields: Array<String> = Type.getInstanceFields(cls);
            for(field in fields) {
                try {
                    Reflect.setField(e, field, Reflect.field(this, field));
                } catch(e: Dynamic) {
                }
            }
            return e;
        }
    }

    private static function genAssignAttributes(assignments:Array<Dynamic>, hasChildren:Bool):Expr {
        var switchStatment:Expr = macro switch(attr) {
            case "xmlns" | "xmlns:xlink":
                continue;
        }
        var cases:Array<Case> = [];

        switch(switchStatment) {
            case {expr: ESwitch({expr: EParenthesis({expr: _})}, c = _, _)}:
                cases = c;
            case _:
        }

        for (assignment in assignments) {
            switch(assignment.type) {
                case FVar(TPath({name: _}), expr = {expr: _}):
                    var c:Case = {values: [{expr: EConst(CString(assignment.name, DoubleQuotes)), pos: Context.currentPos()}], expr: expr};
                    cases.push(c);
                case FVar(TPath({name: "Null", params: [TPType(TPath({name: "Int"}))]})):
                    var e:Expr = macro $i{assignment.name} = Std.parseInt(element.get(attr));
                    var c: Case = {values: [{expr: EConst(CString(assignment.name, DoubleQuotes)), pos: Context.currentPos()}], expr: e};
                    cases.push(c);
                case FVar(TPath({name: "Null", params: [TPType(TPath({name: "Float"}))]})):
                    var e:Expr = macro $i{assignment.name} = Std.parseFloat(element.get(attr));
                    var c: Case = {values: [{expr: EConst(CString(assignment.name, DoubleQuotes)), pos: Context.currentPos()}], expr: e};
                    cases.push(c);
                case FVar(TPath({name: "String"})):
                    var e:Expr = macro $i{assignment.name} = element.get(attr);
                    var c: Case = {values: [{expr: EConst(CString(assignment.name, DoubleQuotes)), pos: Context.currentPos()}], expr: e};
                    cases.push(c);
                case _:
                    var e:Expr = macro trace($v{assignment.name} + " is not implemented.");
                    var c:Case = {values: [{expr: EConst(CString(assignment.name, DoubleQuotes)), pos: Context.currentPos()}], expr: e};
                    cases.push(c);
            }
        }

        var e:Expr = macro setAttribute(attr, element);
        var c:Case = {values: [{expr: EConst(CIdent("_")), pos: Context.currentPos()}], expr: e};
        cases.push(c);

        var assignChildren:Expr = macro null;
        if (hasChildren) {
            assignChildren = macro {
                var elements:Iterator<Xml> = element.elements();
                children = [];
                while (elements.hasNext()) {
                    var xml:Xml = elements.next();
                    var el:SVGElement = SVGParser.parseXml(xml);
                    el.styles = styles;

                    var nodeValue:String = null;
                    if(xml.firstChild() != null) {
                      nodeValue = xml.firstChild().nodeValue;
                    }
                    if(nodeValue != null) {
                        Reflect.setField(el, "inner_content", nodeValue);
                    }

                    children.push(el);
                }
            }
        }

        return macro {
            var attributes:Iterator<String> = element.attributes();
            while (attributes.hasNext()) {
                var attr:String = attributes.next();
                ${switchStatment}
            }
            ${assignChildren}
        };
    }
    #end
}
