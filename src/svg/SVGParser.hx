package svg;
import svg.core.SVGElement;
import svg.elements.Circle;
import svg.elements.Defs;
import svg.elements.Ellipse;
import svg.elements.FeColorMatrix;
import svg.elements.FeGaussianBlur;
import svg.elements.FeMerge;
import svg.elements.FeMergeNode;
import svg.elements.FeOffset;
import svg.elements.Filter;
import svg.elements.G;
import svg.elements.Line;
import svg.elements.LinearGradient;
import svg.elements.Mask;
import svg.elements.Path;
import svg.elements.Polygon;
import svg.elements.Polyline;
import svg.elements.RadialGradient;
import svg.elements.Rect;
import svg.elements.Stop;
import svg.elements.Style;
import svg.elements.SVG;
import svg.elements.Text;
import svg.elements.Title;
import svg.elements.Use;
class SVGParser {
    private static var elementMap: Map<String, Class<SVGElement>> = {
        elementMap = new Map<String, Class<SVGElement>>();
        elementMap.set("svg", SVG);
        elementMap.set("circle", Circle);
        elementMap.set("rect", Rect);
        elementMap.set("title", Title);
        elementMap.set("path", Path);
        elementMap.set("line", Line);
        elementMap.set("g", G);
        elementMap.set("use", Use);
        elementMap.set("polyline", Polyline);
        elementMap.set("polygon", Polygon);
        elementMap.set("defs", Defs);
        elementMap.set("mask", Mask);
        elementMap.set("ellipse", Ellipse);
        elementMap.set("linearGradient", LinearGradient);
        elementMap.set("stop", Stop);
        elementMap.set("filter", Filter);
        elementMap.set("feGaussianBlur", FeGaussianBlur);
        elementMap.set("feOffset", FeOffset);
        elementMap.set("style", Style);
        elementMap.set("text", Text);
        elementMap.set("feColorMatrix", FeColorMatrix);
        elementMap.set("radialGradient", RadialGradient);
        elementMap.set("feMerge", FeMerge);
        elementMap.set("feMergeNode", FeMergeNode);
        elementMap;
    };

    public static function parse(svgString:String):SVG {
        var xml = Xml.parse(svgString);
        return cast parseXml(xml.firstElement());
    }

    public static function parseXml(xml:Xml):SVGElement {
        var nodeName: String = getNodeName(xml);
        var cls: Class<SVGElement> = elementMap.get(nodeName);
        if(cls == null) {
            trace('you forgot to add the element to the map again skyler: ${nodeName}');
            return null;
        }
        var obj: SVGElement = util.ClassUtil.createInstanceFromClass(cls);
        obj.assignAttributes(xml);

        return obj;
    }

    public static inline function getNodeName(xml:Xml):String {
        return Reflect.getProperty(xml, "nodeName");
    }

    public static inline function underscore(str:String):String {
        return StringTools.replace(str, "-", "_");
    }
}
