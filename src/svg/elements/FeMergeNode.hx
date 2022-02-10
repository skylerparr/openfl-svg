package svg.elements;
import svg.core.BaseSVG;
import svg.core.SVGElement;
import svg.core.SVGFilter;
@:build(macros.SVGHelper.build({skipChild: true, skipBounds: true}))
class FeMergeNode extends BaseSVG implements SVGElement implements SVGFilter {
    @prop public var inn:String;

    public function new() {
        super();
    }

    public function render(doc:DOC, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
    }

    public function applyFilter(bitmap:Dynamic, resultMap: Map<String, Dynamic>):Void {
        var bd = Filter.getIn(resultMap, inn);
        Native.setProperty(bitmap, "bitmapData", bd);
    }

}
