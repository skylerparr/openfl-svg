package svg.elements;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class Rect extends BaseSVG implements SVGElement{
    @prop public var x: Null<Float>;
    @prop public var y: Null<Float>;
    @prop public var width: Null<Float>;
    @prop public var height: Null<Float>;
    @prop public var rx: Null<Float>;
    @prop public var ry: Null<Float>;
    @prop public var pathLength: Null<Float>;
    public var children:Array<SVGElement>;

    public function new() {
        super();
    }

    public function render(doc:DOC, defs: Map<String,SVGElement>, inherit:SVGElement = null):Void {
        if(x != null) {
            doc.x += x;
        }
        if(y != null) {
            doc.y += y;
        }
        if(rx == null && ry == null) {
            graphics.drawRect(0, 0, width, height);
        } else {
            if(rx != null && ry == null) {
                ry = rx;
            }
            if(rx == null && ry != null) {
                rx = ry;
            }
            graphics.drawRoundRect(0, 0, width, height, rx, ry);
        }
        for (child in children) {
            child.render(doc, defs, this);
        }
        graphics.endFill();
    }
}
