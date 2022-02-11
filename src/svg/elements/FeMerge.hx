package svg.elements;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
import svg.core.SVGFilter;
@:build(macros.SVGHelper.build({skipChild: true, skipBounds: true}))
class FeMerge extends BaseSVG implements SVGElement implements SVGFilter {
    public var children:Array<SVGElement>;

    public function new() {
        super();
    }

    public function render(sprite:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
    }

    public function applyFilter(bitmap:Bitmap, resultMap: Map<String, BitmapData>):Void {
        var container = new Sprite();
        for (child in children) {
            var svgFilter:SVGFilter = cast child;
            if (svgFilter != null) {
                var bmp = new Bitmap();
                svgFilter.applyFilter(bmp, resultMap);
                container.addChild(bmp);
            }
        }
        var merged = OpenFL.createBitmapData(container);
        bitmap.bitmapData = merged;

        Filter.setResult(resultMap, result, merged);
    }

}
