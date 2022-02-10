package ;
import shaders.BitmapMaskShader;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
class OpenFL {
    public static function createBitmapData(display:DisplayObject):BitmapData {
        var bitmapData: BitmapData = new BitmapData(Std.int(display.width), Std.int(display.height), true, 0);
        bitmapData.draw(display);
        return bitmapData;
    }

    public static function createBitmap(display:DisplayObject):Bitmap {
        return new Bitmap(createBitmapData(display));
    }

    public static function applyMask(display:DisplayObject, mask:DisplayObject):Bitmap {
        var bitmapData: BitmapData = new BitmapData(Std.int(display.width), Std.int(display.height), true, 0);
        bitmapData.draw(display);
        var bitmap: Bitmap = new Bitmap(bitmapData);
        applyMaskToBitmap(bitmap, mask);
        return bitmap;
    }

    public static function applyMaskToBitmap(bitmap:Bitmap, mask:DisplayObject):Void {
        var bitmapDataMask = new BitmapData (bitmap.bitmapData.width, bitmap.bitmapData.height, true, 0);
        bitmapDataMask.draw(mask);

        var shader = new BitmapMaskShader();
        shader.maskImage.input = bitmapDataMask;
        bitmap.shader = shader;
    }
}
