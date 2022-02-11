package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class G extends BaseSVG implements SVGElement {
    public var children:Array<SVGElement>;

    public function new() {
        super();
    }

    public function render(doc:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
        for (child in children) {
            child.render(doc, defs, this);
        }
        graphics.endFill();
    }

}
