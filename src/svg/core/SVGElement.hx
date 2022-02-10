package svg.core;
import openfl.display.Sprite;
interface SVGElement {
    var sprite: Sprite;
    var id: String;
    var styles: Styles;
    var name: String;

    function assignAttributes(element: Xml): Void;
    function render(sprite: Sprite, defs: Map<String,SVGElement>, inherit: SVGElement = null): Void;
    function clone(): SVGElement;
}
