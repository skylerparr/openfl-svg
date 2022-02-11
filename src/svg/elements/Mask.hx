package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class Mask extends BaseSVG implements SVGElement {
    @prop public var height: Null<Float>;
    @prop public var width: Null<Float>;
    @prop public var maskContentUnits: String;
    @prop public var maskUnits: String;
    @prop public var x: Null<Float>;
    @prop public var y: Null<Float>;
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
