package svg.elements;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
import svg.core.SVGFilter;
@:build(macros.SVGHelper.build({skipChild: true, skipBounds: true}))
class FeOffset extends BaseSVG implements SVGElement implements SVGFilter {
    @prop public var inn: String;
    @prop public var dx: Null<Float>;
    @prop public var dy: Null<Float>;

    public function new() {
        super();
    }

    public function render(sprite:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
    }

    public function applyFilter(bmp:Bitmap, resultMap: Map<String, Dynamic>):Void {
        var container: Sprite = new Sprite();
        container.addChild(bmp);

        var bd = bmp.bitmapData;
        var outBitmapData = new BitmapData(bd.width, bd.height);
        outBitmapData.copyPixels(bd, bd.rect, BaseSVG.point);

        var bmpCopy = new Bitmap(outBitmapData);
        bmpCopy.x = dx;
        bmpCopy.y = dy;

        container.addChild(bmpCopy);
        var finalBd = new BitmapData(bd.width, bd.height);
        finalBd.draw(container);

        bmp.bitmapData = finalBd;

        Filter.setResult(resultMap, result, outBitmapData);
    }
}
