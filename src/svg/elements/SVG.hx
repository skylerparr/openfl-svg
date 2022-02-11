package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.Styles;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class SVG extends BaseSVG implements SVGElement {
    @prop public var x:Null<Int>;
    @prop public var y:Null<Int>;
    @prop public var width:Null<Int>;
    @prop public var height:Null<Int>;
    @prop public var version:String;
    @prop public var viewBox:ViewBox = {
        var frags:Array<String> = element.get(attr).split(" ");
        viewBox = {
            x: Std.parseInt(frags[0]),
            y: Std.parseInt(frags[1]),
            width: Std.parseInt(frags[2]),
            height: Std.parseInt(frags[3])
        }
    };
    @prop public var preserveAspectRatio:PreserveAspectRatio = {
        PreserveAspectRatio.xMidYMid;
    };
    public var children:Array<SVGElement>;

    public function new() {
        super();
        styles = new Styles();
    }

    public function render(sprite:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
        if (x != null) {
            sprite.x = x;
        }
        if (y != null) {
            sprite.y = y;
        }

        if (viewBox == null) {
            viewBox = {
                x: 0,
                y: 0,
                width: width,
                height: height
            }
        }

        if (width != null && height == null) {
            sprite.scaleX = width / viewBox.width;
            sprite.scaleY = width / viewBox.width;
        } else if (width == null && height != null) {
            sprite.scaleX = height / viewBox.height;
            sprite.scaleY = height / viewBox.height;
        }

        sprite.x += viewBox.x;
        sprite.y += viewBox.y;

        for (child in children) {
            if (Std.isOfType(child, Filter)) {
                defs.set(child.id, child);
                continue;
            }
            child.render(sprite, defs, this);
        }
        graphics.endFill();
    }

}

typedef ViewBox = {
    x:Int,
    y:Int,
    width:Int,
    height:Int
}

enum PreserveAspectRatio {
    xMidYMid;
}
