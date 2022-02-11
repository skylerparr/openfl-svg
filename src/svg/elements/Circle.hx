package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class Circle extends BaseSVG implements SVGElement {
    @prop public var cx: String;
    @prop public var cy: String;
    @prop public var r: Null<Float>;
    @prop public var pathLength: Null<Int>;
    public var children:Array<SVGElement>;

    public function new() {
        super();
    }

    public function render(doc: Sprite, defs: Map<String,SVGElement>, inherit: SVGElement = null): Void {
        graphics.drawCircle(cx, cy, r);
        for (child in children) {
            child.render(doc, defs, this);
        }
        graphics.endFill();
    }
}
