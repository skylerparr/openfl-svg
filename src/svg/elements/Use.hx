package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build({skipBounds: true}))
class Use extends BaseSVG implements SVGElement {
    @prop public var href: String;
    @prop public var x: Null<Int>;
    @prop public var y: Null<Int>;
    @prop public var width: Null<Int>;
    @prop public var height: Null<Int>;

    public function new() {
        super();
    }

    public function render(doc:Sprite, defs: Map<String,SVGElement>, inherit:SVGElement = null):Void {
        if(href != null) {
            href = StringTools.replace(href, "#", "");
            if(x != null) {
                doc.x = x;
            }
            if(y != null) {
                doc.y = y;
            }
            if(width != null) {
                doc.width = width;
            }
            if(height != null) {
                doc.height = height;
            }

            var ref: SVGElement = defs.get(href);
            if(ref != null) {
                var toRender: SVGElement = ref.clone();
                toRender.render(doc, defs, this);
                graphics.endFill();
            } else {
                trace('attempted to use an undefined svg element ${href}');
            }
        }
    }
}
