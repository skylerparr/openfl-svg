package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class Ellipse extends BaseSVG implements SVGElement {
    @prop public var cx: String;
    @prop public var cy: String;
    @prop public var rx: Null<Float>;
    @prop public var ry: Null<Float>;
    @prop public var pathLength: Null<Int>;
    public var children:Array<SVGElement>;

    public function new() {
        super();
    }

    public function render(sprite: Sprite, defs: Map<String,SVGElement>, inherit: SVGElement = null): Void {
        graphics.drawEllipse(cx, cy, rx, ry);
        for (child in children) {
            child.render(sprite, defs, this);
        }
        graphics.endFill();
    }
}
