package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class Text extends BaseSVG implements SVGElement {
    @prop public var x: Null<Float>;
    @prop public var y: Null<Float>;
    @prop public var dx: Null<Float>;
    @prop public var dy: Null<Float>;
    @prop public var lengthAdjust: String;
    @prop public var textLength: String;

    public var text: String;

    public function new() {
        super();
    }

    public function render(doc:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
        var textField: view.Text = new view.Text();
        textField.init();
        text = inner_content;
        doc.addChild(textField);
        doc.x = x;
        doc.y = y;

        if(font_size != null) {
            textField.size = Std.parseInt(font_size);
        }
        if(font_style == "italic") {
            textField.italic = true;
        } else if(font_style == "bold") {
            textField.bold = true;
        }
        if(fill != null) {
            var fillColor: Int = SVGRender.getColor(fill);
            textField.color = fillColor;
        }
        textField.text = text;
        textField.autoSize = 1;
    }
}
