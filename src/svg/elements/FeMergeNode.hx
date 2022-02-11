package svg.elements;
import flash.display.BitmapData;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
import svg.core.SVGFilter;
@:build(macros.SVGHelper.build({skipChild: true, skipBounds: true}))
class FeMergeNode extends BaseSVG implements SVGElement implements SVGFilter {
    @prop public var inn:String;

    public function new() {
        super();
    }

    public function render(sprite:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
    }

    public function applyFilter(bitmap:Bitmap, resultMap: Map<String, BitmapData>):Void {
        var bd = Filter.getIn(resultMap, inn);
        bitmap.bitmapData = bd;
    }

}
