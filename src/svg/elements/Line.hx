package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class Line extends BaseSVG implements SVGElement {
    @prop public var x1: Null<Int>;
    @prop public var x2: Null<Int>;
    @prop public var y1: Null<Int>;
    @prop public var y2: Null<Int>;

    public function new() {
        super();
    }

    public function render(sprite:Sprite, defs: Map<String,SVGElement>, inherit:SVGElement = null):Void {
        var color:Int = 0;
        if (stroke != null) {
            color = SVGRender.getColor(stroke);
        }
        graphics.lineStyle(1, color);
        if (fill == null || fill == "none") {
            graphics.beginFill(0, 0);
        } else {
            graphics.beginFill(color, 1);
        }

        graphics.moveTo(x1, y1);
        graphics.lineTo(x2, y2);
    }

}
