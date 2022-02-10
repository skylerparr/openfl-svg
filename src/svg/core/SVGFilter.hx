package svg.core;
import openfl.display.Bitmap;
interface SVGFilter {
    function applyFilter(bitmap:Bitmap, resultMap: Map<String, Dynamic>): Void;
}
