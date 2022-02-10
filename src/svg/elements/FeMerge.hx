package svg.elements;
import svg.core.BaseSVG;
import svg.core.SVGElement;
import svg.core.SVGFilter;
@:build(macros.SVGHelper.build({skipChild: true, skipBounds: true}))
class FeMerge extends BaseSVG implements SVGElement implements SVGFilter {
    public var children:Array<SVGElement>;

    public function new() {
        super();
    }

    public function render(doc:DOC, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
    }

    public function applyFilter(bitmap:Dynamic, resultMap: Map<String, Dynamic>):Void {
        var container = ClassUtil.createInstance(ClassConstants.SPRITE);
        for (child in children) {
            var svgFilter:SVGFilter = cast child;
            if (svgFilter != null) {
                var bmp = ClassUtil.createInstance(ClassConstants.BITMAP, []);
                svgFilter.applyFilter(bmp, resultMap);
                container.addChild(bmp);
            }
        }
        var merged = Native.callStatic("OpenFL", "createBitmapData", [container]);
        Native.setProperty(bitmap, "bitmapData", merged);

        Filter.setResult(resultMap, result, merged);
    }

}
