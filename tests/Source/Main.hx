package;

import svg.SVGTest;
import openfl.display.Sprite;

class Main extends Sprite {
  public function new() {
    super();
		var test = new SVGTest();
		test.renderTest();
  }
}
