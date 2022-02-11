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

    public var testToRun: () -> svg.elements.SVG = SVGTestSuite.testMask;
    public var allTests: Array<svg.TestUtils.TestUnit> = SVGTestSuite.allTests();
    public var currentIndex: Int = 0;

    private var layer: Sprite;

    public function new(container) {
        layer = container;
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
            svgButton.graphics.drawRect(0, 0, layer.stage.stageWidth, layer.stage.stageHeight);
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

    public static function clearChildren(container: DisplayObjectContainer): Void {
        while(container.numChildren > 0) {
            var child = container.removeChildAt(0);
            if(Std.isOfType(child, DisplayObjectContainer)) {
                clearChildren(cast child);
            }
        }
    }

}
