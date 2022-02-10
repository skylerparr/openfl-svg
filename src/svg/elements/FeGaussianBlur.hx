package svg.elements;
import openfl.display.Bitmap;
import flash.filters.BlurFilter;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
import svg.core.SVGFilter;
@:build(macros.SVGHelper.build({skipChild: true, skipBounds: true}))
class FeGaussianBlur extends BaseSVG implements SVGElement implements SVGFilter {
    @prop public var stdDeviation: Null<Float>;
    @prop public var inn: String;
    @prop public var edgeMode: String;

    public function new() {
        super();
    }

    public function render(sprite:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
    }

    public function applyFilter(bmp:Bitmap, resultMap: Map<String, Dynamic>):Void {
        var blur = new BlurFilter(stdDeviation, stdDeviation, 2);
        var bd = bmp.bitmapData
        var outBitmapData = Filter.getIn(resultMap, inn);
        var rect = bd.rect;
        rect = bd.generateFilterRect(rect, blur);
        outBitmapData.applyFilter(bd, rect, BaseSVG.point, blur);
        bmp.bitmapData = outBitmapData;
        bd.dispose();

        Filter.setResult(resultMap, result, outBitmapData);

    }

}
