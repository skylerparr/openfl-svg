package svg;
import openfl.display.DisplayObjectContainer;
import openfl.Lib;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;
import openfl.display.Sprite;
import svg.elements.SVG;
import svg.core.SVGElement;
import sys.io.File;
class SVGTest {

    public var testToRun: () -> svg.elements.SVG = SVGTestSuite.testChar;
    public var allTests: Array<svg.TestUtils.TestUnit> = SVGTestSuite.allTests();
    public var currentIndex: Int = 0;

    public function new() {
    }

    public function renderTest(): Void {
        var test: svg.TestUtils.TestUnit = allTests.pop();
        if(testToRun != null) {
            while(test.func != testToRun) {
                test = allTests.pop();
            }
            testToRun = null;
        }
        if(test != null) {
            trace(test.name);
            var svg: SVG = test.func();
            var layer: DisplayObjectContainer = Lib.current.stage;
            clearChildren(layer);
            var svgDisplay = new Sprite();
            svgDisplay.x = 10;
            svgDisplay.y = 10;
            SVGRender.render(svg, svgDisplay, new Map<String, SVGElement>());
            var svgButton: Sprite = new Sprite();
            svgButton.addChild(svgDisplay);
            svgButton.buttonMode = true;
            svgButton.mouseChildren = false;
            svgButton.graphics.clear();
            svgButton.graphics.beginFill(0, 0);
            svgButton.graphics.drawRect(0, 0, layer.width, layer.height);
            svgButton.graphics.endFill();
            svgButton.addEventListener(MouseEvent.CLICK, function(me: MouseEvent): Void {
                renderTest();
            });
            layer.addChild(svgButton);
        } else {
            allTests = SVGTestSuite.allTests();
            renderTest();
        }
    }

    public static function renderPath(path: String): Void {
        var layer: DisplayObjectContainer = Lib.current.stage;
        clearChildren(layer);
        var svgDisplay = new Sprite();
        svgDisplay.x = 10;
        svgDisplay.y = 10;
        trace(Sys.getCwd());
        var content = File.getContent('../../../${path}');
        var svg = SVGParser.parse(content);
        SVGRender.render(svg, svgDisplay, new Map<String, SVGElement>());
        layer.addChild(svgDisplay);
    }

    public static function clearChildren(container: DisplayObjectContainer): Void {
        while(container.numChildren > 0) {
            var child = container.removeChildAt(0);
            clearChildren(child);
        }
    }

}
