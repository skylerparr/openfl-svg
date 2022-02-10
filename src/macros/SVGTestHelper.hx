package macros;
import haxe.macro.Context;
import haxe.macro.Expr.Field;
import haxe.macro.Expr;
class SVGTestHelper {
    macro public static function build(): Array<Field> {
        var fields: Array<Field> = Context.getBuildFields();
        var allTestsField: Field = null;
        var testNames: Array<String> = [];
        for(field in fields) {
            switch(field) {
                case {name: name = "allTests", kind: FFun(_), meta: [{name: "gen"}]}:
                    allTestsField = field;
                case {name: name, kind: FFun(_)}:
                    if(StringTools.startsWith(name, "test")) {
                        testNames.push(name);
                    }
                case _:
            }
        }

        var testsArray: Array<Expr> = [];
        var inst = macro var retVal: Array<svg.TestUtils.TestUnit> = [];
        testsArray.push(inst);
        for(test in testNames) {
            var e = macro retVal.push({name: $v{test}, func: $i{test}});
            testsArray.push(e);
        }
        var r = macro {
            retVal.reverse();
            return retVal;
        }
        testsArray.push(r);
        var block: Expr = {expr: EBlock(testsArray), pos: Context.currentPos()};

        switch(allTestsField.kind) {
            case FFun(func = _):
                func.expr = block;

            case _:
        }

        return fields;
    }
}
