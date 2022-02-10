package svg.elements;
import openfl.geom.Rectangle;
import openfl.display.Bitmap;
import openfl.filters.ColorMatrixFilter.ColorMatrixShader;
import flash.display.BitmapData;
import util.MathUtil;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
import svg.core.SVGFilter;
@:build(macros.SVGHelper.build({skipChild: true, skipBounds: true}))
class FeColorMatrix extends BaseSVG implements SVGElement implements SVGFilter {
    @prop public var inn:String;
    @prop public var type:String;
    @prop public var values:Array<Float> = {
        var str:String = element.get(attr);
        str = StringTools.trim(str);
        values = [];
        var value:String = "";
        for (i in 0...str.length) {
            var char:String = str.charAt(i);
            if (char == " " && value.length > 0) {
                value = StringTools.trim(value);
                values.push(Std.parseFloat(value));
                value = "";
            } else {
                value += char;
                value = StringTools.trim(value);
            }
        }
        value = StringTools.trim(value);
        values.push(Std.parseFloat(value));

        values;
    };

    public function new() {
        super();
    }

    public function render(sprite:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
    }

    public function applyFilter(bmp:Bitmap, resultMap: Map<String, Dynamic>):Void {
        var colorMatrix = new ColorMatrixShader();
        if (values != null) {
            if (type == "saturate") {
                var value:Float = values[0];
                var rwgt = 0.3086;
                var gwgt = 0.3086;
                var bwgt = 0.3086;
                values = [(1.0 - value) * rwgt + value, (1.0 - value) * rwgt, (1.0 - value) * rwgt, 0, 0,
                (1.0 - value) * gwgt, (1.0 - value) * gwgt + value, (1.0 - value) * gwgt, 0, 0,
                (1.0 - value) * bwgt, (1.0 - value) * bwgt, (1.0 - value) * bwgt + value, 0, 0,
                0, 0, 0, 1, 0];
            } else if (type == "hueRotate") {
                var hueRotationDegrees:Float = values[0];
                var cosA:Float = Math.cos(MathUtil.degreesToRadians(hueRotationDegrees));
                var sinA:Float = Math.sin(MathUtil.degreesToRadians(hueRotationDegrees));
                values = [cosA + (1.0 - cosA) / 3.0, 1.0 / 3.0 * (1.0 - cosA) - Math.sqrt(1.0 / 3.0) * sinA, 1.0 / 3.0 * (1.0 - cosA) + Math.sqrt(1.0 / 3.0) * sinA, 0, 0,
                1.0 / 3.0 * (1.0 - cosA) + Math.sqrt(1.0 / 3.0) * sinA, cosA + 1.0 / 3.0 * (1.0 - cosA), 1.0 / 3.0 * (1.0 - cosA) - Math.sqrt(1.0 / 3.0) * sinA, 0, 0,
                1.0 / 3.0 * (1.0 - cosA) - Math.sqrt(1.0 / 3.0) * sinA, 1.0 / 3.0 * (1.0 - cosA) + Math.sqrt(1.0 / 3.0) * sinA, cosA + 1.0 / 3.0 * (1.0 - cosA), 0, 0,
                0, 0, 0, 1, 0];

            }
        } else if (type == "luminanceToAlpha") {
            values = [
                0, 0, 0, 0, 0,
                0, 0, 0, 0, 0,
                0, 0, 0, 0, 0,
                0.2126, 0.7152, 0.0722, 1, 0];
        }
        Reflect.setProperty(colorMatrix, "matrix", values);
        values = null;

        var bd: BitmapData = bmp.bitmapData;
        var outBitmapData: BitmapData = Filter.getIn(resultMap, inn);
        var rect: Rectangle = bd.rect;
        rect = bd.generateFilterRect(rect, colorMatrix);
        outBitmapData.applyFilter(bd, rect, BaseSVG.point, colorMatrix);
        bmp.bitmapData = outBitmapData;
        bd.dispose();

        Filter.setResult(resultMap, result, outBitmapData);
    }

    private inline function sepia():Array<Float> {
        return [0.393, 0.769, 0.189, 0, 0,
        0.349, 0.686, 0.168, 0, 0,
        0.272, 0.534, 0.131, 0, 0,
        0, 0, 0, 1, 0];
    }

    private inline function matrix3DRawDataToArray(raw:Dynamic):Array<Float> {
        var length:Int = Reflect.getProperty(raw, "length");
        var retVal:Array<Float> = [];
        var counter:Int = 0;
        while (length > 0) {
            if (counter % 5 == 0) {
                retVal.unshift(0);
            }
            var value:Float = raw.pop();
            retVal.unshift(value);
            length = Reflect.getProperty(raw, "length");
            counter++;
        }
        return retVal;
    }
}
