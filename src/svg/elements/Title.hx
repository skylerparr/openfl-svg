package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class Title extends BaseSVG implements SVGElement{
    @prop public var text: String;

    public function new() {
        super();
    }

    public function render(doc:Sprite, defs: Map<String,SVGElement>, inherit:SVGElement = null):Void {

    }
}
