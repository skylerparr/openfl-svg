package svg.elements;
import openfl.geom.Matrix;
import util.MathUtil;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build({skipChild: true}))
class LinearGradient extends BaseSVG implements SVGElement {
    @prop public var gradientUnits: String;
    @prop public var gradientTransform: String;
    @prop public var href: String;
    @prop public var spreadMethod: String;
    @prop public var x1: Null<Float>;
    @prop public var x2: Null<Float>;
    @prop public var y1: Null<Float>;
    @prop public var y2: Null<Float>;
    public var children:Array<SVGElement>;

    public function new() {
        super();
    }

    public function render(sprite:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
        var matr: Matrix = new Matrix();
        var rotation: Float = MathUtil.degreesToRadians(0);
        if (gradientTransform != null) {
            if (StringTools.startsWith(gradientTransform, "rotate")) {
                var coordsStr:String = StringTools.replace(gradientTransform, "rotate(", "");
                coordsStr = StringTools.replace(coordsStr, ")", "");
                rotation = MathUtil.degreesToRadians(Std.parseFloat(coordsStr));
            } else {
                trace('${gradientTransform} is not implemented yet. LMK if you see this and I\'ll get it fixed');
            }
        }
        var colors = [];
        var ratios = [0, 255];
        for(child in children) {
            var stop: Stop = cast child;
            colors.push(SVGRender.getColor(stop.stop_color));
        }

        matr.createGradientBox(100, 100, rotation, 0, 0);

        graphics.beginGradientFill(0, colors, [1, 1], ratios, matr, 0);
    }
}
