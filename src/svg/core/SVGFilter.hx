package svg.core;
import flash.display.BitmapData;
import openfl.display.Bitmap;
interface SVGFilter {
    function applyFilter(bitmap:Bitmap, resultMap: Map<String, BitmapData>): Void;
}
