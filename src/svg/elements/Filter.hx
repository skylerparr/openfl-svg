package svg.elements;
import util.BitmapUtil;
import openfl.display.Sprite;
import openfl.display.BitmapData;
import svg.core.BaseSVG;
import svg.core.SVGElement;
import svg.core.SVGFilter;
@:build(macros.SVGHelper.build({skipChild: true}))
class Filter extends BaseSVG implements SVGElement {
    @prop public var x:Null<Float>;
    @prop public var y:Null<Float>;
    @prop public var width:Null<Float>;
    @prop public var height:Null<Float>;
    @prop public var filterUnits:String;
    public var children:Array<SVGElement>;

    public function new() {
        super();
    }

    public function render(sprite:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
        var container:Sprite = new Sprite();
        container.x = sprite.x;
        container.y = sprite.y;

        var bmp = BitmapUtil.createBitmap(sprite);
        sprite.parent.addChild(container);
        sprite.parent.removeChild(sprite);
        bmp.x = x;
        bmp.y = y;
        container.addChild(bmp);
        var resultMap = new Map<String, BitmapData>();
        var bd = bmp.bitmapData;
        var sourceBitmapData = bmp.bitmapData.clone();
        resultMap.set("SourceGraphic", sourceBitmapData);
        for (child in children) {
            var svgFilter:SVGFilter = cast child;
            if (svgFilter != null) {
                svgFilter.applyFilter(bmp, resultMap);
            }
        }
    }

    public static function getIn(resultMap:Map<String, BitmapData>, inn:String): BitmapData {
        var outBitmapData: BitmapData = null;
        switch(inn) {
            case "SourceGraphic":
                outBitmapData = resultMap.get("SourceGraphic").clone();
            case "SourceAlpha":
                if (resultMap.exists("SourceAlpha")) {
                    outBitmapData = resultMap.get("SourceAlpha").clone();
                } else {
                    var bd = resultMap.get("SourceGraphic").clone();
                    outBitmapData = resultMap.get("SourceGraphic").clone();
                    bd.lock();
                    outBitmapData.lock();
                    for(i in 0...bd.width) {
                        for(j in 0...bd.height) {
                            var px = bd.getPixel32(i, j);
                            var alpha = getAlpha(px);
                            outBitmapData.setPixel(i, j, alpha);
                        }
                    }
                    bd.unlock();
                    outBitmapData.unlock();
                    resultMap.set("SourceAlpha", outBitmapData);
                }
            case "BackgroundImage":
            case "BackgroundAlpha":
            case "FillPaint":
            case "StrokePaint":
            case null:
                if(resultMap.exists("_")) {
                    outBitmapData = resultMap.get("_").clone();
                } else {
                    outBitmapData = resultMap.get("SourceGraphic").clone();
                }
            case _:
                outBitmapData = resultMap.get(inn).clone();
        }
        return outBitmapData;
    }

    public static function setResult(resultMap:Map<String, Dynamic>, result:String, outBitmapData:BitmapData):Void {
        if(result != null) {
            resultMap.set(result, outBitmapData);
        } else {
            resultMap.set("_", outBitmapData);
        }
    }

    public static function getAlpha(color32:Int):Int {
        var alpha = StringTools.hex(color32, 8).substring(0, 2) + "000000";
        return Std.parseInt('0x${alpha}');
    }
}
