package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class Polygon extends BaseSVG implements SVGElement {
    @prop public var points: Array<Float> = {
        var value:String = element.get(attr);
        points = [];
        var coords: Array<String> = value.split(" ");
        for(coord in coords) {
            var ps: Array<String> = coord.split(",");
            for(p in ps) {
                points.push(Std.parseFloat(p));
            }
        }
        points;
    }
    @prop public var pathLength: Null<Float>;

    public function new() {
        super();
    }

    public function render(doc:Sprite, defs: Map<String,SVGElement>, inherit:SVGElement = null):Void {
        var p: Array<Float> = points.copy();

        var startX: Float = p.shift();
        var startY: Float = p.shift();
        graphics.moveTo(startX, startY);
        while(p.length > 0) {
            graphics.lineTo(p.shift(), p.shift());
        }
        graphics.lineTo(startX, startY);
    }
}
