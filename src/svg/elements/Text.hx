package svg.elements;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextField;
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

    public function render(sprite:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
        var textField: TextField = new TextField();
        var textFormat: TextFormat = new TextFormat();
        text = inner_content;
        sprite.addChild(textField);
        sprite.x = x;
        sprite.y = y;

        if(font_size != null) {
            textFormat.size = Std.parseInt(font_size);
        }
        if(font_style == "italic") {
            textFormat.italic = true;
        } else if(font_style == "bold") {
            textFormat.bold = true;
        }
        if(fill != null) {
            var fillColor: Int = SVGRender.getColor(fill);
            textFormat.color = fillColor;
        }
        textField.text = text;
        textField.autoSize = TextFieldAutoSize.LEFT;
        textField.setTextFormat(textFormat);
        textField.defaultTextFormat = textFormat;
    }
}
