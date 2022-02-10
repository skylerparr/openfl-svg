package svg;
import svg.SVGParser;
import svg.elements.SVG;
import sys.io.File;
@:build(macros.SVGTestHelper.build())
class SVGTestSuite {

    @gen public static function allTests(): Array<svg.TestUtils.TestUnit> {

    }

    public static function testSVG():SVG {
       return SVGParser.parse('<svg viewBox="0 0 300 100" xmlns="http://www.w3.org/2000/svg" stroke="#ff0000" fill="#808080">
  <circle cx="50" cy="50" r="40" />
  <circle cx="150" cy="50" r="4" />

  <svg viewBox="0 0 10 10" x="200" width="100">
    <circle cx="5" cy="5" r="4" />
  </svg>
</svg>');
    }

    public static function testCircle():SVG {
       return SVGParser.parse('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <circle cx="50" cy="50" r="50"/>
</svg>');
    }

    public static function testEllipse():SVG {
       return SVGParser.parse('<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg">
  <ellipse cx="100" cy="50" rx="100" ry="50" />
</svg>>');
    }

    public static function testRect():SVG {
       return SVGParser.parse('<svg viewBox="0 0 220 100" xmlns="http://www.w3.org/2000/svg">
  <!-- Simple rectangle -->
  <rect width="100" height="100" />

  <!-- Rounded corner rectangle -->
  <rect x="120" width="100" height="100" rx="15" />
</svg>');
    }

    public static function testTitle():SVG {
       return SVGParser.parse('<svg viewBox="0 0 20 10" xmlns="http://www.w3.org/2000/svg">
  <circle cx="5" cy="5" r="4">
    <title>I\'m a circle</title>
       </circle>

       <rect x="11" y="1" width="8" height="8">
       <title>I\'m a square</title>
  </rect>
</svg>');
    }

    public static function testLine():SVG {
       return SVGParser.parse('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <line x1="0" y1="80" x2="100" y2="20" stroke="0x000000" />

  <!-- If you do not specify the stroke
       color the line will not be visible -->
</svg>');
    }

    public static function testG():SVG {
       return SVGParser.parse('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <!-- Using g to inherit presentation attributes -->
  <g fill="#FFFFFF" stroke="#00FF00" stroke-width="5">
    <circle cx="40" cy="40" r="25" />
    <circle cx="60" cy="60" r="25" />
  </g>
</svg>');
    }

    public static function testUse():SVG {
       return SVGParser.parse('<svg viewBox="0 0 30 10" xmlns="http://www.w3.org/2000/svg">
  <circle id="myCircle" cx="10" cy="10" r="10" stroke="blue"/>
  <use href="#myCircle" x="30" fill="blue"/>
  <use href="#myCircle" x="70" fill="white" stroke="red"/>
  <!--
stroke="red" will be ignored here, as stroke was already set on myCircle.
Most attributes (except for x, y, width, height and (xlink:)href)
do not override those set in the ancestor.
That\'s why the circles have different x positions, but the same stroke value.
       -->
       </svg>');
    }

    public static function testPolyline():SVG {
       return SVGParser.parse('<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg">
  <!-- Example of a polyline with the default fill -->
  <polyline points="0,100 50,25 50,75 100,0" />

  <!-- Example of the same polyline shape with stroke and no fill -->
  <polyline points="100 100 150 25 150 75 200 0"
            fill="none" stroke="black" />
</svg>');
    }

    public static function testTranslate():SVG {
       return SVGParser.parse('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <!-- No translation -->
  <rect x="5" y="5" width="40" height="40" fill="green" />

  <!-- Horizontal translation -->
  <rect x="5" y="5" width="40" height="40" fill="blue"
        transform="translate(50)" />

  <!-- Vertical translation -->
  <rect x="5" y="5" width="40" height="40" fill="red"
        transform="translate(0 50)" />

  <!-- Both horizontal and vertical translation -->
  <rect x="5" y="5" width="40" height="40" fill="yellow"
         transform="translate(50,50)" />
</svg>');
    }

    public static function testScale():SVG {
       return SVGParser.parse('<svg viewBox="50 50 100 100" xmlns="http://www.w3.org/2000/svg">
  <!-- uniform scale -->
  <circle cx="0" cy="0" r="10" fill="red"
          transform="scale(4)" />

  <!-- vertical scale -->
  <circle cx="0" cy="0" r="10" fill="yellow"
          transform="scale(1,4)" />

  <!-- horizontal scale -->
  <circle cx="0" cy="0" r="10" fill="pink"
          transform="scale(4,1)" />

  <!-- No scale -->
  <circle cx="0" cy="0" r="10" fill="black" />
</svg>');
    }

    public static function testRotate():SVG {
       return SVGParser.parse('<svg viewBox="12 12 34 14" xmlns="http://www.w3.org/2000/svg">
  <rect x="0" y="0" width="10" height="10" />

  <!-- rotation is done around the point 0,0 -->
  <rect x="0" y="0" width="10" height="10" fill="red"
        transform="rotate(100)" />

  <!-- rotation is done around the point 10,10 -->
  <rect x="0" y="0" width="10" height="10" fill="green"
        transform="rotate(100,10,10)" />
</svg>');
    }

    public static function testPath1():SVG {
       return SVGParser.parse('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <path fill="none" stroke="#ff0000"
    d="M 10,10 h 10
       m  0,10 h 10
       m  0,10 h 10
       M 40,20 h 10
       m  0,10 h 10
       m  0,10 h 10
       m  0,10 h 10
       M 50,50 h 10
       m-20,10 h 10
       m-20,10 h 10
       m-20,10 h 10" />
</svg>');
    }

    public static function testPath2():SVG {
       return SVGParser.parse('<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg">
  <!-- LineTo commands with absolute coordinates -->
  <path fill="none" stroke="#ff0000"
        d="M 10,10
           L 90,90
           V 10
           H 50" />

  <!-- LineTo commands with relative coordinates -->
  <path fill="none" stroke="#ff0000"
        d="M 110,10
           l 80,80
           v -80
           h -40" />
</svg>');
    }

    public static function testPath3():SVG {
       return SVGParser.parse('<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">

  <!-- Cubic Bézier curve with absolute coordinates -->
  <path fill="none" stroke="red"
        d="M 10,90
           C 30,90 25,10 50,10
           S 70,90 90,90" />

  <!-- Cubic Bézier curve with relative coordinates -->
  <path fill="none" stroke="red"
        d="M 110,90
           c 20,0 15,-80 40,-80
           s 20,80 40,80" />

  <!-- Highlight the curve vertex and control points -->
  <g id="ControlPoints">

    <!-- First cubic command control points -->
    <line x1="10" y1="90" x2="30" y2="90" stroke="lightgrey" />
    <circle cx="30" cy="90" r="1.5"/>

    <line x1="50" y1="10" x2="25" y2="10" stroke="lightgrey" />
    <circle cx="25" cy="10" r="1.5"/>

    <!-- Second smooth command control points (the first one is implicit) -->
    <line x1="50" y1="10" x2="75" y2="10" stroke="lightgrey" stroke-dasharray="2" />
    <circle cx="75" cy="10" r="1.5" fill="lightgrey"/>

    <line x1="90" y1="90" x2="70" y2="90" stroke="lightgrey" />
    <circle cx="70" cy="90" r="1.5" />

    <!-- curve vertex points -->
    <circle cx="10" cy="90" r="1.5"/>
    <circle cx="50" cy="10" r="1.5"/>
    <circle cx="90" cy="90" r="1.5"/>
  </g>
  <use href="#ControlPoints" x="100" />
</svg>');
    }

    public static function testPath4():SVG {
       return SVGParser.parse('<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">

  <!-- Quadratic Bézier curve with implicit repetition -->
  <path fill="none" stroke="red"
        d="M 10,50
           Q 25,25 40,50
           t 30,0 30,0 30,0 30,0 30,0" />

  <!-- Highlight the curve vertex and control points -->
  <g>
    <polyline points="10,50 25,25 40,50" stroke="rgba(0,0,0,.2)" fill="none" />
    <circle cx="25" cy="25" r="1.5" />

    <!-- Curve vertex points -->
    <circle cx="10" cy="50" r="1.5"/>
    <circle cx="40" cy="50" r="1.5"/>

    <g id="SmoothQuadraticDown">
      <polyline points="40,50 55,75 70,50" stroke="rgba(0,0,0,.2)" stroke-dasharray="2" fill="none" />
      <circle cx="55" cy="75" r="1.5" fill="lightgrey" />
      <circle cx="70" cy="50" r="1.5" />
    </g>

    <g id="SmoothQuadraticUp">
      <polyline points="70,50 85,25 100,50" stroke="rgba(0,0,0,.2)" stroke-dasharray="2" fill="none" />
      <circle cx="85" cy="25" r="1.5" fill="lightgrey" />
      <circle cx="100" cy="50" r="1.5" />
    </g>

    <use xlink:href="#SmoothQuadraticDown" x="60" />
    <use xlink:href="#SmoothQuadraticUp"   x="60" />
    <use xlink:href="#SmoothQuadraticDown" x="120" />
  </g>
</svg>');
    }

    public static function testPath5():SVG {
       return SVGParser.parse('<svg viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">

  <!-- The influence of the arc flags with which the arc is drawn -->
  <path fill="none" stroke="red"
        d="M 6,10
           A 6 4 10 1 0 14,10" />

  <path fill="none" stroke="lime"
        d="M 6,10
           A 6 4 10 1 1 14,10" />

  <path fill="none" stroke="purple"
        d="M 6,10
           A 6 4 10 0 1 14,10" />

  <path fill="none" stroke="pink"
        d="M 6,10
           A 6 4 10 0 0 14,10" />
</svg>');
    }

    public static function testPath6():SVG {
       return SVGParser.parse('<svg viewBox="0 -1 30 11" xmlns="http://www.w3.org/2000/svg">

  <!--
  An open shape with the last point of
  the path different to the first one
  -->
  <path stroke="red"
        d="M 5,1
           l -4,8 8,0" />

  <!--
  An open shape with the last point of
  the path matching the first one
  -->
  <path stroke="red"
        d="M 15,1
           l -4,8 8,0 -4,-8" />

  <!--
  A closed shape with the last point of
  the path different to the first one
  -->
  <path stroke="red"
        d="M 25,1
           l -4,8 8,0
           z" />
</svg>');
    }

    public static function testPath7():SVG {
       return SVGParser.parse('<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <path d="M 10,30
           A 20,20 0,0,1 50,30
           A 20,20 0,0,1 90,30
           Q 90,60 50,90
           Q 10,60 10,30 z"/>
</svg>');
    }

    public static function testPolygon():SVG {
       return SVGParser.parse('<svg viewBox="0 0 200 100" xmlns="http://www.w3.org/2000/svg">
  <!-- Example of a polygon with the default fill -->
  <polygon points="0,100 50,25 50,75 100,0" />

  <!-- Example of the same polygon shape with stroke and no fill -->
  <polygon points="100 100 150 25 150 75 200 0"
            fill="none" stroke="black" />
</svg>');
    }

    public static function testMask():SVG {
       return SVGParser.parse('<svg viewBox="-10 -10 120 120">
  <mask id="myMask">
    <!-- Everything under a white pixel will be visible -->
    <rect x="0" y="0" width="100" height="100" fill="white" />

    <!-- Everything under a black pixel will be invisible -->
    <path d="M10,35 A20,20,0,0,1,50,35 A20,20,0,0,1,90,35 Q90,65,50,95 Q10,65,10,35 Z" fill="black" />
  </mask>

  <polygon points="-10,110 110,110 110,-10" fill="orange" />

  <!-- with this mask applied, we "punch" a heart shape hole into the circle -->
  <circle cx="50" cy="50" r="50" mask="url(#myMask)" />
</svg>');
    }

    public static function testDefs():SVG {
        return SVGParser.parse('<svg viewBox="0 0 10 10" xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs>
    <linearGradient id="myGradient" gradientTransform="rotate(90)">
      <stop offset="5%"  stop-color="gold" />
      <stop offset="95%" stop-color="red" />
    </linearGradient>
  </defs>

  <!-- using my linear gradient -->
  <circle cx="50" cy="50" r="25" fill="url(\'#myGradient\')" />
</svg>');
    }

    public static function testFilter():SVG {
        return SVGParser.parse('<svg width="230" height="120" xmlns="http://www.w3.org/2000/svg">
  <filter id="blurMe">
    <feGaussianBlur stdDeviation="5"/>
  </filter>

  <circle cx="60" cy="60" r="50" fill="green"/>

  <circle cx="170" cy="60" r="50" fill="green" filter="url(#blurMe)"/>
</svg>');
    }

    public static function testRadialGradient():SVG {
        return SVGParser.parse('<svg viewBox="0 0 50 50" xmlns="http://www.w3.org/2000/svg"
     xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs>
    <radialGradient id="myGradient">
      <stop offset="10%" stop-color="gold" />
      <stop offset="95%" stop-color="red" />
    </radialGradient>
  </defs>

  <!-- using my radial gradient -->
  <circle cx="50" cy="50" r="40" fill="url(\'#myGradient\')" />
</svg>');
    }

    public static function testFeOffset():SVG {
        return SVGParser.parse('<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <filter id="offset" width="180" height="180">
      <feOffset in="SourceGraphic" dx="60" dy="60" />
    </filter>
  </defs>

  <rect x="0" y="0" width="100" height="100" stroke="black" fill="green"/>
  <rect x="20" y="20" width="100" height="100" stroke="black" fill="green" filter="url(#offset)"/>
</svg>');
    }

    public static function testBlurOffset():SVG {
        return SVGParser.parse('
<svg width="100%" height="220" style="outline: 1px solid red">
 <defs>
   <filter id="drop-shadow-3">
     <feGaussianBlur in="SourceAlpha" stdDeviation="2" result="blur"/>
     <feOffset in="blur" dx="4" dy="4" result="offsetBlur"/>
     <feMerge>
       <feMergeNode in="offsetBlur"/>
       <feMergeNode in="SourceGraphic"/>
     </feMerge>
   </filter>
 </defs>

 <rect x="10" y="10" width="100" height="100" fill="#0000ff" filter="url(#drop-shadow-3)" />
</svg>');
    }

    public static function testFeMerge():SVG {
        return SVGParser.parse('<svg width="200" height="200"
  xmlns="http://www.w3.org/2000/svg">

  <filter id="feOffset" x="-40" y="-20" width="100" height="200">
    <feOffset in="SourceGraphic" dx="60" dy="60" />
    <feGaussianBlur stdDeviation="5" result="blur2" />
    <feMerge>
      <feMergeNode in="blur2" />
      <feMergeNode in="SourceGraphic" />
    </feMerge>
  </filter>

  <rect x="40" y="40" width="100" height="100"
    style="stroke: #000000; fill: green; filter: url(#feOffset);" />
</svg>>');
    }

    public static function testStyle():SVG {
        return SVGParser.parse('<svg viewBox="0 0 10 10" xmlns="http://www.w3.org/2000/svg">
  <style>
    circle {
      fill: gold;
      stroke: maroon;
      stroke-width: 2px;
    }
  </style>

  <circle cx="5" cy="5" r="4" />
</svg>');
    }

    public static function testText():SVG {
        return SVGParser.parse('<svg viewBox="0 0 240 80" xmlns="http://www.w3.org/2000/svg">
  <style>
    .small { font: italic 13px sans-serif; }
    .heavy { font: bold 30px sans-serif; }

    /* Note that the color of the text is set with the    *
     * fill property, the color property is for HTML only */
    .Rrrrr { font: italic 40px serif; fill: red; }
  </style>

  <text x="20" y="35" class="small">My</text>
  <text x="40" y="35" class="heavy">cat</text>
  <text x="55" y="55" class="small">is</text>
  <text x="65" y="55" class="Rrrrr">Grumpy!</text>
</svg>');
    }

    public static function testFeColorMatrix():SVG {
        return SVGParser.parse('<svg width="100%" height="100%" viewBox="0 0 150 150"
    preserveAspectRatio="xMidYMid meet"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink">

  <!-- ref -->
  <defs>
    <g id="circles">
      <circle cx="30" cy="30" r="20" fill="blue" fill-opacity="0.5" />
      <circle cx="20" cy="50" r="20" fill="green" fill-opacity="0.5" />
      <circle cx="40" cy="50" r="20" fill="red" fill-opacity="0.5" />
    </g>
  </defs>
  <use href="#circles" />
  <text x="70" y="50">Reference</text>

  <!-- identity matrix -->
  <filter id="colorMeTheSame">
    <feColorMatrix in="SourceGraphic"
        type="matrix"
        values="1 0 0 0 0
                0 1 0 0 0
                0 0 1 0 0
                0 0 0 1 0" />
   </filter>
  <use href="#circles" transform="translate(0 70)" filter="url(#colorMeTheSame)" />
  <text x="70" y="120">Identity matrix</text>

  <!-- Combine RGB into green matrix -->
  <filter id="colorMeGreen">
    <feColorMatrix in="SourceGraphic"
        type="matrix"
        values="0 0 0 0 0
                1 1 1 1 0
                0 0 0 0 0
                0 0 0 1 0" />
  </filter>
  <use href="#circles" transform="translate(0 140)" filter="url(#colorMeGreen)" />
  <text x="70" y="190">rgbToGreen</text>

  <!-- saturate -->
  <filter id="colorMeSaturate">
    <feColorMatrix in="SourceGraphic"
        type="saturate"
        values="0.2" />
  </filter>
  <use href="#circles" transform="translate(0 210)" filter="url(#colorMeSaturate)" />
  <text x="70" y="260">saturate</text>

  <!-- hueRotate -->
  <filter id="colorMeHueRotate">
    <feColorMatrix in="SourceGraphic"
        type="hueRotate"
        values="180" />
  </filter>
  <use href="#circles" transform="translate(0 280)" filter="url(#colorMeHueRotate)" />
  <text x="70" y="330">hueRotate</text>

  <!-- luminanceToAlpha -->
  <filter id="colorMeLTA">
    <feColorMatrix in="SourceGraphic"
        type="luminanceToAlpha" />
  </filter>
  <use href="#circles" transform="translate(0 350)" filter="url(#colorMeLTA)" />
  <text x="70" y="400">luminanceToAlpha</text>
</svg>
');
    }

    public static function testResource():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}svg/cloud_00.svg');
       return SVGParser.parse(content);
    }

    public static function testResource1():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}svg/cloud_00_rain.svg');
       return SVGParser.parse(content);
    }

    public static function testResource2():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}svg/stone_00.svg');
       return SVGParser.parse(content);
    }

    public static function testResource3():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}svg/stone_01.svg');
       return SVGParser.parse(content);
    }

    public static function testResource4():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}svg/stone_02.svg');
       return SVGParser.parse(content);
    }

    public static function testResource5():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}svg/tree_00.svg');
       return SVGParser.parse(content);
    }

    public static function testResource6():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}svg/tree_evergreen00.svg');
       return SVGParser.parse(content);
    }

    public static function testChar():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}avatars/test-char.svg');
       return SVGParser.parse(content);
    }

    public static function testChar2():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}avatars/panda-flat.svg');
        return SVGParser.parse(content);
    }

    public static function testChar3():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}avatars/cabearet-flat.svg');
        return SVGParser.parse(content);
    }

    public static function testChar4():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}avatars/Bubbles_flat.svg');
        return SVGParser.parse(content);
    }

    public static function testAvatar12200():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}avatars/test_avatar_1_22_00.svg');
        return SVGParser.parse(content);
    }

    public static function testAvatar12201():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}avatars/test_avatar_1_22_01.svg');
        return SVGParser.parse(content);
    }

    public static function testAvatar12202():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}avatars/test_avatar_1_22_02.svg');
        return SVGParser.parse(content);
    }

    public static function testAvatar12203():SVG {
        var content = File.getContent('${Environment.getApplicationSettings().getBaseAssetsPath()}avatars/test_avatar_1_22_03.svg');
        return SVGParser.parse(content);
    }
}
