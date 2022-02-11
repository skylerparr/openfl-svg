package svg.core;
import openfl.display.Graphics;
import openfl.geom.Rectangle;
import openfl.geom.Point;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import svg.core.SVGElement;
import util.ClassUtil;
import util.MathUtil;
class BaseSVG {
    public static var point: Point = new Point();
    public static var rect: Rectangle = new Rectangle();
    public static var matrix: Matrix = new Matrix();

    public var alignment_baseline: String;
    public var baseline_shift: String;
    public var clazz: String;
    public var clip: String;
    public var clip_path: String;
    public var clip_rule: String;
    public var color: String;
    public var color_interpolation: String;
    public var color_interpolation_filters: String;
    public var color_profile: String;
    public var color_rendering: String;
    public var cursor: String;
    public var direction: String;
    public var display: String;
    public var dominant_baseline: String;
    public var enable_background: String;
    public var fill: String;
    public var fill_opacity: String;
    public var fill_rule: String;
    public var filter: String;
    public var flood_color: String;
    public var flood_opacity: String;
    public var font_family: String;
    public var font_size: String;
    public var font_size_adjust: String;
    public var font_stretch: String;
    public var font_style: String;
    public var font_variant: String;
    public var font_weight: String;
    public var glyph_orientation_horizontal: String;
    public var glyph_orientation_vertical: String;
    public var id: String;
    public var inner_content: String;
    public var image_rendering: String;
    public var kerning: String;
    public var letter_spacing: String;
    public var lighting_color: String;
    public var marker_end: String;
    public var marker_mid: String;
    public var marker_start: String;
    public var mask: String;
    public var opacity: String;
    public var overflow: String;
    public var pointer_events: String;
    public var result: String;
    public var shape_rendering: String;
    public var solid_color: String;
    public var solid_opacity: String;
    public var stop_color: String;
    public var stop_opacity: String;
    public var stroke: String;
    public var stroke_dasharray: String;
    public var stroke_dashoffset: String;
    public var stroke_linecap: String;
    public var stroke_linejoin: String;
    public var stroke_miterlimit: String;
    public var stroke_opacity: String;
    public var stroke_width: String;
    public var style: String;
    public var text_anchor: String;
    public var text_decoration: String;
    public var text_rendering: String;
    public var transform: String;
    public var unicode_bidi: String;
    public var vector_effect: String;
    public var visibility: String;
    public var word_spacing: String;
    public var writing_mode: String;

    public var renderSprite: Sprite;
    private var displayMatrix: Matrix;

    public function new() {
    }

    public function setAttribute(attr: String, element: Xml): Void {
        if(attr == "xlink:href") {
            Reflect.setProperty(this, "href", element.get(attr));
        } else if(attr == "in") {
            Reflect.setProperty(this, "inn", element.get(attr));
        } else if(attr == "class") {
            Reflect.setProperty(this, "clazz", element.get(attr));
        } else {
            Reflect.setProperty(this, SVGParser.underscore(attr), element.get(attr));
        }
    }

    public function getLink(url: String): String {
        var link: String = StringTools.replace(url, "url(", "");
        link = StringTools.replace(link, ")", "");
        link = StringTools.replace(link, "#", "");
        link = StringTools.replace(link, "'", "");
        return link;
    }

    public function initialDraw(doc: Sprite, defs: Map<String, SVGElement>, graphics: Graphics): Void {
        if(style != null) {
            var css = parseCSSNode(style);
            var fields: Array<String> = Reflect.fields(css);
            for(field in fields) {
                Reflect.setProperty(this, field, Reflect.field(css, field));
            }
        }

        var shouldSetLineStyle: Bool = false;
        var fillColor: Int = 0;
        if(fill == "none") {
            graphics.beginFill(fillColor, 0);
        } else if(fill == null) {
            graphics.beginFill(0, 1);
        } else {
            fillColor = SVGRender.getColor(fill);
            var fillOpacity: Float = 1;
            if(fill_opacity != null) {
                fillOpacity = Std.parseFloat(fill_opacity);
            }
            graphics.beginFill(fillColor, fillOpacity);
        }
        var strokeColor: Int = 0;
        if(stroke != null && stroke != "none") {
            strokeColor = SVGRender.getColor(stroke);
            shouldSetLineStyle = true;
        }
        if(shouldSetLineStyle) {
            var strokeWidth: Int = Std.parseInt(stroke_width);
            graphics.lineStyle(strokeWidth, strokeColor);
        }
        if(fill != null) {
            var el: SVGElement = getById(defs, fill);
            if(el != null) {
                var clone: SVGElement = el.clone();
                clone.render(doc, defs, null);
            }
        }

        if(opacity != null) {
            var value: Float = Std.parseFloat(opacity);
            doc.alpha = value;
        }

        // Transformations should not be inherited, since it's
        // already inherited from the display tree
        applyTransformations(doc);
        transform = null;
    }

    public function postDraw(doc: Sprite, defs: Map<String, SVGElement>, graphics: Graphics): Void {
        if(mask != null) {
            var link: String = getLink(mask);
            var el: SVGElement = defs.get(link);
            if(el != null) {
                el = el.clone();
                var bmp = OpenFL.applyMask(doc, el.doc);
                doc.parent.addChild(bmp);
                doc.parent.removeChild(doc);
                el.doc.parent.removeChild(el.doc);
            }
        }
        if(filter != null) {
            var link: String = getLink(filter);
            var el: SVGElement = defs.get(link);
            if(el != null) {
                el = el.clone();
                el.render(doc, defs);
            }
        }
    }

    private inline function getById(defs: Map<String, SVGElement>, id: String): SVGElement {
        var link = getLink(id);
        return defs.get(link);
    }

    public inline function parseCSSNode(content: String): Dynamic {
        var retVal: Dynamic = {};
        var nodeName: String = "";
        var value: String = "";
        var nodeNameSet: Bool = false;
        for(i in 0...content.length) {
            var char: String = content.charAt(i);
            if(char == ":") {
                nodeNameSet = true;
                nodeName = StringTools.trim(nodeName);
                nodeName = StringTools.replace(nodeName, "-", "_");
            } else if(char == ";") {
                value = StringTools.trim(value);
                Reflect.setField(retVal, nodeName, value);
                value = "";
                nodeName = "";
                nodeNameSet = false;
            } else {
                if(nodeNameSet) {
                    value += char;
                } else {
                    nodeName += char;
                }
            }
        }
        return retVal;
    }

    public function applyTransformations(doc: Sprite): Void {
        if(transform == null) {
            return;
        }
        displayMatrix = getMatrix(doc);
        parseAndApplyTransformations(doc);
        setMatrix(doc, displayMatrix);
    }

    public static inline function extractArgs(str: String): Array<Null<Float>> {
        var args: Array<Float> = [];
        var value: String = "";
        for(i in 0...str.length) {
            var charCode: Int = str.charCodeAt(i);
            if(charCode == 44 || charCode == 32) {
                value = StringTools.trim(value);
                if(value == "") {
                    continue;
                }
                args.push(Std.parseFloat(value));
                value = "";
            } else {
                value += str.charAt(i);
            }
        }
        value = StringTools.trim(value);
        args.push(Std.parseFloat(value));
        return args;
    }

    public function parseAndApplyTransformations(doc: Sprite): Void {
        var transforms: Array<Dynamic> = [];
        var func: String = "";
        var str: String = "";
        for(i in 0...transform.length) {
            var char: String = transform.charAt(i);
            if(char == "(") {
                func = StringTools.trim(str);
                str = "";
            } else if(char == ")") {
                var fn = Reflect.field(this, func);
                if(fn == null) {
                    trace('function ${func} is not defined');
                } else {
                    var args: Array<Dynamic> = extractArgs(str);
                    args.unshift(doc);
                    transforms.unshift({fn: fn, args: args});
                }
                func = "";
                str = "";
            } else {
                str += char;
            }
        }
        for(tr in transforms) {
            Reflect.callMethod(this, tr.fn, tr.args);
        }
    }

    private inline function getMatrix(doc: Sprite): Matrix {
        return doc.transform.matrix;
    }

    private inline function setMatrix(doc: Sprite, displayMatrix: Matrix): Void {
       doc.transform.matrix = displayMatrix;
    }

    public function translate(x: Float, y: Float): Void {
        displayMatrix.translate(x, y);
    }

    public function scale(x: Null<Float>, y: Null<Float>): Void {
        if(y == null) {
            y = x;
        }
        displayMatrix.scale(x, y);
    }

    public function rotate(r: Float, x: Null<Int>, y: Null<Int>): Void {
        if(x == null) {
            x = 0;
        }
        if(y == null) {
            y = 0;
        }
        displayMatrix.translate(-x, -y);
        displayMatrix.rotate(MathUtil.degreesToRadians(r));
        displayMatrix.translate(x, y);
    }

}
