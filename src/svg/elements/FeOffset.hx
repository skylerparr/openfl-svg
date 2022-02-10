package svg.elements;
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

    public function render(doc:DOC, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
    }

    public function applyFilter(bmp:Dynamic, resultMap: Map<String, Dynamic>):Void {
        var container: DOC = new DOC();
        container.init();
        container._sprite.addChild(bmp);

        var bd = Native.getProperty(bmp, "bitmapData");
        var outBitmapData = ClassUtil.createInstance(ClassConstants.BITMAP_DATA, [bd.width, bd.height]);
        Native.call(outBitmapData, "copyPixels", [bd, bd.rect, BaseSVG.point]);

        var bmpCopy = ClassUtil.createInstance(ClassConstants.BITMAP, [outBitmapData]);
        Native.setProperty(bmpCopy, "x", dx);
        Native.setProperty(bmpCopy, "y", dy);

        container._sprite.addChild(bmpCopy);
        var finalBd = ClassUtil.createInstance(ClassConstants.BITMAP_DATA, [bd.width, bd.height]);
        Native.call(finalBd, "draw", [container._sprite]);

        Native.setProperty(bmp, "bitmapData", finalBd);

        var layer = DOCLayerManager.getLayerByName(LayerNames.UI_DESIGNER_MODAL);
        container.x = 400;
        layer.addChild(container);

        Filter.setResult(resultMap, result, outBitmapData);
    }
}
