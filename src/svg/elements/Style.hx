package svg.elements;
import openfl.display.Sprite;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build({skipChild: true, skipBounds: true}))
class Style extends BaseSVG implements SVGElement {
    public function new() {
        super();
    }

    public function render(doc:Sprite, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
        var isClass: Bool = false;
        var isId: Bool = false;
        var gatherContent: Bool = false;
        var nodeName: String = "";
        var content: String = "";
        for(i in 0...inner_content.length) {
            var char: String = inner_content.charAt(i);
            switch(char) {
                case ".":
                    isClass = true;
                    nodeName = "";
                    content = "";
                case "#":
                    isId = true;
                    nodeName = "";
                    content = "";
                case "{":
                    nodeName = StringTools.trim(nodeName);
                    gatherContent = true;
                case "}":
                    var data = parseCSSNode(content);
                    if(isId) {
                        styles.ids.set(nodeName, data);
                    } else if(isClass) {
                        styles.classes.set(nodeName, data);
                    } else {
                        styles.topLevel.set(nodeName, data);
                    }
                    isClass = false;
                    isId = false;
                    gatherContent = false;
                    nodeName = "";
                    content = "";
                case _:
                    if(gatherContent) {
                        content += char;
                    } else {
                        nodeName += char;
                    }
            }
        }
    }

}
