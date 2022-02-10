package svg.core;
import svg.core.SVGElement;
class Styles {
    public var topLevel: Map<String, Dynamic> = new Map<String, Dynamic>();
    public var classes: Map<String, Dynamic> = new Map<String, Dynamic>();
    public var ids: Map<String, Dynamic> = new Map<String, Dynamic>();

    public function new() {
    }

    public function applyTopLevelStyle(svg:SVGElement, name:String):Void {
        var styles: Dynamic = topLevel.get(name);
        if(styles != null) {
            applyStyles(svg, styles);
        }
    }

    public function applyClassStyle(svg:SVGElement, name:String):Void {
        var styles: Dynamic = classes.get(name);
        var fields: Array<String> = Reflect.fields(styles);
        for(field in fields) {
            if(field == "font") {
                var font = Reflect.field(styles, field);
                var frags: Array<String> = font.split(" ");
                Reflect.setField(svg, "font_style", frags[0]);
                Reflect.setField(svg, "font_size", frags[1]);
                Reflect.setField(svg, "font_family", frags[2]);
                continue;
            }

            try {
                Reflect.setField(svg, field, Reflect.field(styles, field));
            } catch(e: Dynamic) {
                trace(e);
            }
        }
    }

    private function applyStyles(svg: SVGElement, styles: Dynamic): Void {
        var fields: Array<String> = Reflect.fields(styles);
        for(field in fields) {
            try {
                Reflect.setField(svg, field, Reflect.field(styles, field));
            } catch(e: Dynamic) {
                trace(e);
            }
        }
    }
}
