package svg.elements;
import svg.core.BaseSVG;
import svg.core.SVGElement;
@:build(macros.SVGHelper.build())
class Path extends BaseSVG implements SVGElement {
    static inline var MOVE = "M";
    static inline var MOVER = "m";
    static inline var LINE = "L";
    static inline var LINER = "l";
    static inline var HLINE = "H";
    static inline var HLINER = "h";
    static inline var VLINE = "V";
    static inline var VLINER = "v";
    static inline var CUBIC = "C";
    static inline var CUBICR = "c";
    static inline var SCUBIC = "S";
    static inline var SCUBICR = "s";
    static inline var QUAD = "Q";
    static inline var QUADR = "q";
    static inline var SQUAD = "T";
    static inline var SQUADR = "t";
    static inline var ARC = "A";
    static inline var ARCR = "a";
    static inline var CLOSE = "Z";
    static inline var CLOSER = "z";

    static var parseMap:Map<String, (cmd: String) -> Array<Float>> = {
        parseMap = new Map<String, (cmd: String) -> Array<Float>>();
        parseMap.set(MOVE, parseCoords);
        parseMap.set(MOVER, parseCoords);
        parseMap.set(HLINE, parseCoords);
        parseMap.set(HLINER, parseCoords);
        parseMap.set(VLINE, parseCoords);
        parseMap.set(VLINER, parseCoords);
        parseMap.set(LINE, parseCoords);
        parseMap.set(LINER, parseCoords);
        parseMap.set(CUBIC, parseCoords);
        parseMap.set(CUBICR, parseCoords);
        parseMap.set(SCUBIC, parseCoords);
        parseMap.set(SCUBICR, parseCoords);
        parseMap.set(QUAD, parseCoords);
        parseMap.set(QUADR, parseCoords);
        parseMap.set(SQUAD, parseCoords);
        parseMap.set(SQUADR, parseCoords);
        parseMap.set(ARC, parseCoords);
        parseMap.set(ARCR, parseCoords);
        parseMap.set(CLOSE, parseCoords);
        parseMap.set(CLOSER, parseCoords);
        parseMap;
    }

    static var twoArgCommandMap:Map<String, (Path, Float, Float) -> Void> = {
        twoArgCommandMap = new Map<String, (Path, Float, Float) -> Void>();
        twoArgCommandMap.set(MOVE, renderMove);
        twoArgCommandMap.set(MOVER, renderMoveR);
        twoArgCommandMap.set(HLINE, renderHorizontalLine);
        twoArgCommandMap.set(HLINER, renderHorizontalLineR);
        twoArgCommandMap.set(VLINE, renderVerticalLine);
        twoArgCommandMap.set(VLINER, renderVerticalLineR);
        twoArgCommandMap.set(LINE, renderLine);
        twoArgCommandMap.set(LINER, renderLineR);
        twoArgCommandMap.set(SQUAD, renderSQuad);
        twoArgCommandMap.set(SQUADR, renderSQuadR);
        twoArgCommandMap;
    }

    static var sixArgCommandMap:Map<String, (Path, Float, Float, Float, Float, Float, Float) -> Void> = {
        sixArgCommandMap = new Map<String, (Path, Float, Float, Float, Float, Float, Float) -> Void>();
        sixArgCommandMap.set(CUBIC, renderCubic);
        sixArgCommandMap.set(CUBICR, renderCubicR);
        sixArgCommandMap;
    }

    static var sevenArgCommandMap:Map<String, (Path, Float, Float, Float, Float, Float, Float, Float) -> Void> = {
        sevenArgCommandMap = new Map<String, (Path, Float, Float, Float, Float, Float, Float, Float) -> Void>();
        sevenArgCommandMap.set(ARC, renderArc);
        sevenArgCommandMap.set(ARCR, renderArcR);
        sevenArgCommandMap;
    }

    static var fourArgCommandMap:Map<String, (Path, Float, Float, Float, Float) -> Void> = {
        fourArgCommandMap = new Map<String, (Path, Float, Float, Float, Float) -> Void>();
        fourArgCommandMap.set(SCUBIC, renderSCubic);
        fourArgCommandMap.set(SCUBICR, renderSCubicR);
        fourArgCommandMap.set(QUAD, renderQuad);
        fourArgCommandMap.set(QUADR, renderQuadR);
        fourArgCommandMap;
    }

    @prop public var d:Array<PathInstruction> = {
        var value:String = element.get(attr);
        d = [];
        var command:String = null;
        var data:String = "";
        for (i in 0...value.length) {
            var char:String = value.charAt(i);
            if (command == null) {
                command = char;
            } else if (parseMap.exists(char)) {
                var value = parseCoords(StringTools.trim(data));
                d.push({command: command, data: value});
                command = char;
                data = "";
            } else {
                data += char;
            }
        }
        var value = parseCoords(StringTools.trim(data));
        d.push({command: command, data: value});

        d;
    };

    public var previousX:Float;
    public var previousY:Float;
    public var previousCX:Float;
    public var previousCY:Float;
    public var lastMoveX:Float;
    public var lastMoveY:Float;
    public var currentPI:PathInstruction;

    public function new() {
        super();
    }

    private static function parseCoords(value:String):Array<Float> {
        value = StringTools.trim(value);
        var split:Array<String> = value.split(" ");

        var frags:Array<Float> = [];
        for (f in split) {
            var f:Array<String> = f.split(",");
            for (x in f) {
                x = StringTools.trim(x);
                if (x == "") {
                    continue;
                }
                frags.push(Std.parseFloat(x));
            }
        }
        return frags;
    }

    public function render(doc:DOC, defs:Map<String, SVGElement>, inherit:SVGElement = null):Void {
        for (pi in d) {
            currentPI = pi;
            if (twoArgCommandMap.exists(currentPI.command)) {
                var f:(Path, Float, Float) -> Void = twoArgCommandMap.get(currentPI.command);
                var data:Array<Float> = pi.data.copy();
                while (data.length > 0) {
                    f(this, data.shift(), data.shift());
                }
            } else if (sixArgCommandMap.exists(currentPI.command)) {
                var f:(Path, Float, Float, Float, Float, Float, Float) -> Void = sixArgCommandMap.get(currentPI.command);
                var data:Array<Float> = pi.data.copy();
                while (data.length > 0) {
                    f(this, data.shift(), data.shift(), data.shift(), data.shift(), data.shift(), data.shift());
                }
            } else if (fourArgCommandMap.exists(currentPI.command)) {
                var f:(Path, Float, Float, Float, Float) -> Void = fourArgCommandMap.get(currentPI.command);
                var data:Array<Float> = pi.data.copy();
                while (data.length > 0) {
                    f(this, data.shift(), data.shift(), data.shift(), data.shift());
                }
            } else if (sevenArgCommandMap.exists(currentPI.command)) {
                var f:(Path, Float, Float, Float, Float, Float, Float, Float) -> Void = sevenArgCommandMap.get(currentPI.command);
                var data:Array<Float> = pi.data.copy();
                while (data.length > 0) {
                    f(this, data.shift(), data.shift(), data.shift(), data.shift(), data.shift(), data.shift(), data.shift());
                }
            } else if(currentPI.command == CLOSE) {
                renderClose(this);
            } else if(currentPI.command == CLOSER) {
                renderClose(this);
            }
        }
    }

    private static function renderMove(path:Path, x:Float, y:Float):Void {
        doMove(path, x, y);
    }

    private static function renderMoveR(path:Path, x:Float, y:Float):Void {
        doMove(path, x + path.previousX, y + path.previousY);
    }

    private static function doMove(path:Path, x:Float, y:Float):Void {
        path.previousX = x;
        path.previousY = y;
        path.lastMoveX = x;
        path.lastMoveY = y;
        path.graphics.moveTo(x, y);
    }

    private static function renderLine(path:Path, x:Float, y:Float):Void {
        doRenderLine(path, x, y);
    }

    private static function renderLineR(path:Path, x:Float, y:Float):Void {
        doRenderLine(path, x + path.previousX, y + path.previousY);
    }

    private static function doRenderLine(path:Path, x:Float, y:Float):Void {
        path.previousX = x;
        path.previousY = y;
        path.graphics.curveTo(x, y, x, y);
    }

    private static function renderHorizontalLine(path:Path, x:Float, y:Float):Void {
        doRenderLine(path, x, path.previousY);
    }

    private static function renderHorizontalLineR(path:Path, x:Float, y:Float):Void {
        doRenderLine(path, x + path.previousX, path.previousY);
    }

    private static function renderVerticalLine(path:Path, x:Float, y:Float):Void {
        doRenderLine(path, path.previousX, x);
    }

    private static function renderVerticalLineR(path:Path, x:Float, y:Float):Void {
        doRenderLine(path, path.previousX, x + path.previousY);
    }

    private static function doRenderCubic(path:Path, inCX1:Float, inCY1:Float, inCX2:Float, inCY2:Float, x:Float, y:Float):Void {
        path.previousX = x;
        path.previousY = y;
        path.previousCX = inCX2;
        path.previousCY = inCY2;
        path.graphics.cubicCurveTo(inCX1, inCY1, inCX2, inCY2, x, y);
    }

    private static function renderCubic(path:Path, inCX1:Float, inCY1:Float, inCX2:Float, inCY2:Float, inX:Float, inY:Float):Void {
        doRenderCubic(path, inCX1, inCY1, inCX2, inCY2, inX, inY);
    }

    private static function renderCubicR(path:Path, inCX1:Float, inCY1:Float, inCX2:Float, inCY2:Float, inX:Float, inY:Float):Void {
        var rx = path.previousX;
        var ry = path.previousY;
        doRenderCubic(path,
        inCX1 + rx,
        inCY1 + ry,
        inCX2 + rx,
        inCY2 + ry,
        inX + rx,
        inY + ry
        );
    }

    private static function renderSCubic(path:Path, inCX1:Float, inCY1:Float, inX:Float, inY:Float):Void {
        var rx = path.previousX;
        var ry = path.previousY;
        var cx = path.previousCX;
        var cy = path.previousCY;
        doRenderCubic(path, rx * 2 - cx, ry * 2 - cy, inCX1, inCY1, inX, inY);
    }

    private static function renderSCubicR(path:Path, inCX1:Float, inCY1:Float, inX:Float, inY:Float):Void {
        var rx = path.previousX;
        var ry = path.previousY;
        var cx = path.previousCX;
        var cy = path.previousCY;
        doRenderCubic(path, rx * 2 - cx, ry * 2 - cy, inCX1 + rx, inCY1 + ry, inX + rx, inY + ry);
    }

    private static function doRenderQuad(path:Path, inCX1:Float, inCY1:Float, x:Float, y:Float):Void {
        path.previousX = x;
        path.previousY = y;
        path.previousCX = inCX1;
        path.previousCY = inCY1;
        path.graphics.curveTo(inCX1, inCY1, x, y);
    }

    public static function renderQuad(path:Path, inCX1:Float, inCY1:Float, inX:Float, inY:Float):Void {
        doRenderQuad(path, inCX1, inCY1, inX, inY);
    }

    public static function renderQuadR(path:Path, inCX1:Float, inCY1:Float, inX:Float, inY:Float):Void {
        var rx = path.previousX;
        var ry = path.previousY;
        doRenderQuad(path, inCX1 + rx, inCY1 + ry, inX + rx, inY + ry);
    }

    public static function renderSQuad(path:Path, inX:Float, inY:Float):Void {
        var rx = path.previousX;
        var ry = path.previousY;
        var cx = path.previousCX;
        var cy = path.previousCY;
        doRenderQuad(path, rx * 2 - cx, ry * 2 - cy, inX, inY);
    }

    public static function renderSQuadR(path:Path, inX:Float, inY:Float):Void {
        var rx = path.previousX;
        var ry = path.previousY;
        var cx = path.previousCX;
        var cy = path.previousCY;
        doRenderQuad(path, rx * 2 - cx, ry * 2 - cy, inX + rx, inY + ry);
    }

    public static function renderArc(path:Path, inRX:Float, inRY:Float, inRotation:Float,
                                     inLargeArc:Float, inSweep:Float, x:Float, y:Float):Void {
        doRenderArc(path, path.previousX, path.previousY, inRX, inRY, inRotation, inLargeArc, inSweep, x, y);
    }

    public static function renderArcR(path:Path, inRX:Float, inRY:Float, inRotation:Float,
                                      inLargeArc:Float, inSweep:Float, x:Float, y:Float):Void {
        var rx = path.previousX;
        var ry = path.previousY;
        doRenderArc(path, rx, ry, inRX, inRY, inRotation, inLargeArc, inSweep, x + rx, y + ry);
    }

    public static function doRenderArc(path: Path, inX1:Float, inY1:Float, inRX:Float, inRY:Float, inRotation:Float,
                                       inLargeArc:Float, inSweep:Float, x:Float, y:Float):Void {
        var x1:Float = inX1;
        var y1:Float = inY1;
        var rx:Float = inRX;
        var ry:Float = inRY;
        var phi:Float = inRotation;
        var fA:Bool = inLargeArc != 0.;
        var fS:Bool = inSweep != 0.;

        if (x1 == x && y1 == y) {
            return;
        }
        path.previousX = x;
        path.previousY = y;
        if (rx == 0 || ry == 0) {
            path.graphics.lineTo(path.previousX, path.previousY);
            return;
        }
        if (rx < 0) rx = -rx;
        if (ry < 0) ry = -ry;

        // See:  http://www.w3.org/TR/SVG/implnote.html#ArcImplementationNotes
        var p = phi * Math.PI / 180.0;
        var cos = Math.cos(p);
        var sin = Math.sin(p);

        // Step 1, compute x', y'
        var dx = (x1 - x) * 0.5;
        var dy = (y1 - y) * 0.5;
        var x1_ = cos * dx + sin * dy;
        var y1_ = -sin * dx + cos * dy;

        // Step 2, compute cx', cy'
        var rx2 = rx * rx;
        var ry2 = ry * ry;
        var x1_2 = x1_ * x1_;
        var y1_2 = y1_ * y1_;
        var s = (rx2 * ry2 - rx2 * y1_2 - ry2 * x1_2) /
        (rx2 * y1_2 + ry2 * x1_2 );
        if (s < 0)
            s = 0;
        else if (fA == fS)
            s = -Math.sqrt(s);
        else
            s = Math.sqrt(s);

        var cx_ = s * rx * y1_ / ry;
        var cy_ = -s * ry * x1_ / rx;

        // Step 3, compute cx,cy from cx',cy'
        // Something not quite right here.

        var xm = (x1 + x) * 0.5;
        var ym = (y1 + y) * 0.5;

        var cx = cos * cx_ - sin * cy_ + xm;
        var cy = sin * cx_ + cos * cy_ + ym;

        var theta = Math.atan2((y1_ - cy_) / ry, (x1_ - cx_) / rx);
        var dtheta = Math.atan2((-y1_ - cy_) / ry, (-x1_ - cx_) / rx) - theta;

        if (fS && dtheta < 0)
            dtheta += 2.0 * Math.PI;
        else if (!fS && dtheta > 0)
            dtheta -= 2.0 * Math.PI;


        var Txc:Float;
        var Txs:Float;
        var Tx0:Float;
        var Tyc:Float;
        var Tys:Float;
        var Ty0:Float;
        Txc = rx;
        Txs = 0;
        Tx0 = cx;
        Tyc = 0;
        Tys = ry;
        Ty0 = cy;

        var len = Math.abs(dtheta) * Math.sqrt(Txc * Txc + Txs * Txs + Tyc * Tyc + Tys * Tys);
        // TODO: Do as series of quadratics ...
        len *= 5;
        var steps = Math.round(len);


        if (steps > 1) {
            dtheta /= steps;
            for (i in 1...steps - 1) {
                var c = Math.cos(theta);
                var s = Math.sin(theta);
                theta += dtheta;
                path.graphics.lineTo(Txc * c + Txs * s + Tx0, Tyc * c + Tys * s + Ty0);
            }
        }
        path.graphics.lineTo(path.previousX, path.previousY);
    }

    public static function renderClose(path:Path):Void {
        doRenderLine(path, path.lastMoveX, path.lastMoveY);
    }

    public static function renderCloseR(path:Path):Void {
        doRenderLine(path, path.lastMoveX, path.lastMoveY);
    }
}

typedef PathInstruction = {
    command:String,
    data:Array<Float>
}
