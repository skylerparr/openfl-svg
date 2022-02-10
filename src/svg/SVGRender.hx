package svg;
import openfl.display.Graphics;
import openfl.display.Sprite;
import svg.core.SVGElement;
import svg.elements.SVG;
class SVGRender {
  public static function render(svg: SVG, display: Sprite, defs: Map<String, SVGElement>): Void {
    svg.render(display, defs);
  }

  public static function getGraphics(sprite: Sprite): Graphics {
    return sprite.graphics;
  }

  public static var cssColorMap: Map<String, Int> = {
    cssColorMap = new Map<String, Int>();
    cssColorMap.set("AliceBlue".toLowerCase(), getColor("#F0F8FF"));
    cssColorMap.set("AntiqueWhite".toLowerCase(), getColor("#FAEBD7"));
    cssColorMap.set("Aqua".toLowerCase(), getColor("#00FFFF"));
    cssColorMap.set("Aquamarine".toLowerCase(), getColor("#7FFFD4"));
    cssColorMap.set("Azure".toLowerCase(), getColor("#F0FFFF"));
    cssColorMap.set("Beige".toLowerCase(), getColor("#F5F5DC"));
    cssColorMap.set("Bisque".toLowerCase(), getColor("#FFE4C4"));
    cssColorMap.set("Black".toLowerCase(), getColor("#000000"));
    cssColorMap.set("BlanchedAlmond".toLowerCase(), getColor("#FFEBCD"));
    cssColorMap.set("Blue".toLowerCase(), getColor("#0000FF"));
    cssColorMap.set("BlueViolet".toLowerCase(), getColor("#8A2BE2"));
    cssColorMap.set("Brown".toLowerCase(), getColor("#A52A2A"));
    cssColorMap.set("BurlyWood".toLowerCase(), getColor("#DEB887"));
    cssColorMap.set("CadetBlue".toLowerCase(), getColor("#5F9EA0"));
    cssColorMap.set("Chartreuse".toLowerCase(), getColor("#7FFF00"));
    cssColorMap.set("Chocolate".toLowerCase(), getColor("#D2691E"));
    cssColorMap.set("Coral".toLowerCase(), getColor("#FF7F50"));
    cssColorMap.set("CornflowerBlue".toLowerCase(), getColor("#6495ED"));
    cssColorMap.set("Cornsilk".toLowerCase(), getColor("#FFF8DC"));
    cssColorMap.set("Crimson".toLowerCase(), getColor("#DC143C"));
    cssColorMap.set("Cyan".toLowerCase(), getColor("#00FFFF"));
    cssColorMap.set("DarkBlue".toLowerCase(), getColor("#00008B"));
    cssColorMap.set("DarkCyan".toLowerCase(), getColor("#008B8B"));
    cssColorMap.set("DarkGoldenRod".toLowerCase(), getColor("#B8860B"));
    cssColorMap.set("DarkGray".toLowerCase(), getColor("#A9A9A9"));
    cssColorMap.set("DarkGrey".toLowerCase(), getColor("#A9A9A9"));
    cssColorMap.set("DarkGreen".toLowerCase(), getColor("#006400"));
    cssColorMap.set("DarkKhaki".toLowerCase(), getColor("#BDB76B"));
    cssColorMap.set("DarkMagenta".toLowerCase(), getColor("#8B008B"));
    cssColorMap.set("DarkOliveGreen".toLowerCase(), getColor("#556B2F"));
    cssColorMap.set("Darkorange".toLowerCase(), getColor("#FF8C00"));
    cssColorMap.set("DarkOrchid".toLowerCase(), getColor("#9932CC"));
    cssColorMap.set("DarkRed".toLowerCase(), getColor("#8B0000"));
    cssColorMap.set("DarkSalmon".toLowerCase(), getColor("#E9967A"));
    cssColorMap.set("DarkSeaGreen".toLowerCase(), getColor("#8FBC8F"));
    cssColorMap.set("DarkSlateBlue".toLowerCase(), getColor("#483D8B"));
    cssColorMap.set("DarkSlateGray".toLowerCase(), getColor("#2F4F4F"));
    cssColorMap.set("DarkSlateGrey".toLowerCase(), getColor("#2F4F4F"));
    cssColorMap.set("DarkTurquoise".toLowerCase(), getColor("#00CED1"));
    cssColorMap.set("DarkViolet".toLowerCase(), getColor("#9400D3"));
    cssColorMap.set("DeepPink".toLowerCase(), getColor("#FF1493"));
    cssColorMap.set("DeepSkyBlue".toLowerCase(), getColor("#00BFFF"));
    cssColorMap.set("DimGray".toLowerCase(), getColor("#696969"));
    cssColorMap.set("DimGrey".toLowerCase(), getColor("#696969"));
    cssColorMap.set("DodgerBlue".toLowerCase(), getColor("#1E90FF"));
    cssColorMap.set("FireBrick".toLowerCase(), getColor("#B22222"));
    cssColorMap.set("FloralWhite".toLowerCase(), getColor("#FFFAF0"));
    cssColorMap.set("ForestGreen".toLowerCase(), getColor("#228B22"));
    cssColorMap.set("Fuchsia".toLowerCase(), getColor("#FF00FF"));
    cssColorMap.set("Gainsboro".toLowerCase(), getColor("#DCDCDC"));
    cssColorMap.set("GhostWhite".toLowerCase(), getColor("#F8F8FF"));
    cssColorMap.set("Gold".toLowerCase(), getColor("#FFD700"));
    cssColorMap.set("GoldenRod".toLowerCase(), getColor("#DAA520"));
    cssColorMap.set("Gray".toLowerCase(), getColor("#808080"));
    cssColorMap.set("Grey".toLowerCase(), getColor("#808080"));
    cssColorMap.set("Green".toLowerCase(), getColor("#008000"));
    cssColorMap.set("GreenYellow".toLowerCase(), getColor("#ADFF2F"));
    cssColorMap.set("HoneyDew".toLowerCase(), getColor("#F0FFF0"));
    cssColorMap.set("HotPink".toLowerCase(), getColor("#FF69B4"));
    cssColorMap.set("IndianRed".toLowerCase(), getColor("#CD5C5C"));
    cssColorMap.set("Indigo".toLowerCase(), getColor("#4B0082"));
    cssColorMap.set("Ivory".toLowerCase(), getColor("#FFFFF0"));
    cssColorMap.set("Khaki".toLowerCase(), getColor("#F0E68C"));
    cssColorMap.set("Lavender".toLowerCase(), getColor("#E6E6FA"));
    cssColorMap.set("LavenderBlush".toLowerCase(), getColor("#FFF0F5"));
    cssColorMap.set("LawnGreen".toLowerCase(), getColor("#7CFC00"));
    cssColorMap.set("LemonChiffon".toLowerCase(), getColor("#FFFACD"));
    cssColorMap.set("LightBlue".toLowerCase(), getColor("#ADD8E6"));
    cssColorMap.set("LightCoral".toLowerCase(), getColor("#F08080"));
    cssColorMap.set("LightCyan".toLowerCase(), getColor("#E0FFFF"));
    cssColorMap.set("LightGoldenRodYellow".toLowerCase(), getColor("#FAFAD2"));
    cssColorMap.set("LightGray".toLowerCase(), getColor("#D3D3D3"));
    cssColorMap.set("LightGrey".toLowerCase(), getColor("#D3D3D3"));
    cssColorMap.set("LightGreen".toLowerCase(), getColor("#90EE90"));
    cssColorMap.set("LightPink".toLowerCase(), getColor("#FFB6C1"));
    cssColorMap.set("LightSalmon".toLowerCase(), getColor("#FFA07A"));
    cssColorMap.set("LightSeaGreen".toLowerCase(), getColor("#20B2AA"));
    cssColorMap.set("LightSkyBlue".toLowerCase(), getColor("#87CEFA"));
    cssColorMap.set("LightSlateGray".toLowerCase(), getColor("#778899"));
    cssColorMap.set("LightSlateGrey".toLowerCase(), getColor("#778899"));
    cssColorMap.set("LightSteelBlue".toLowerCase(), getColor("#B0C4DE"));
    cssColorMap.set("LightYellow".toLowerCase(), getColor("#FFFFE0"));
    cssColorMap.set("Lime".toLowerCase(), getColor("#00FF00"));
    cssColorMap.set("LimeGreen".toLowerCase(), getColor("#32CD32"));
    cssColorMap.set("Linen".toLowerCase(), getColor("#FAF0E6"));
    cssColorMap.set("Magenta".toLowerCase(), getColor("#FF00FF"));
    cssColorMap.set("Maroon".toLowerCase(), getColor("#800000"));
    cssColorMap.set("MediumAquaMarine".toLowerCase(), getColor("#66CDAA"));
    cssColorMap.set("MediumBlue".toLowerCase(), getColor("#0000CD"));
    cssColorMap.set("MediumOrchid".toLowerCase(), getColor("#BA55D3"));
    cssColorMap.set("MediumPurple".toLowerCase(), getColor("#9370D8"));
    cssColorMap.set("MediumSeaGreen".toLowerCase(), getColor("#3CB371"));
    cssColorMap.set("MediumSlateBlue".toLowerCase(), getColor("#7B68EE"));
    cssColorMap.set("MediumSpringGreen".toLowerCase(), getColor("#00FA9A"));
    cssColorMap.set("MediumTurquoise".toLowerCase(), getColor("#48D1CC"));
    cssColorMap.set("MediumVioletRed".toLowerCase(), getColor("#C71585"));
    cssColorMap.set("MidnightBlue".toLowerCase(), getColor("#191970"));
    cssColorMap.set("MintCream".toLowerCase(), getColor("#F5FFFA"));
    cssColorMap.set("MistyRose".toLowerCase(), getColor("#FFE4E1"));
    cssColorMap.set("Moccasin".toLowerCase(), getColor("#FFE4B5"));
    cssColorMap.set("NavajoWhite".toLowerCase(), getColor("#FFDEAD"));
    cssColorMap.set("Navy".toLowerCase(), getColor("#000080"));
    cssColorMap.set("OldLace".toLowerCase(), getColor("#FDF5E6"));
    cssColorMap.set("Olive".toLowerCase(), getColor("#808000"));
    cssColorMap.set("OliveDrab".toLowerCase(), getColor("#6B8E23"));
    cssColorMap.set("Orange".toLowerCase(), getColor("#FFA500"));
    cssColorMap.set("OrangeRed".toLowerCase(), getColor("#FF4500"));
    cssColorMap.set("Orchid".toLowerCase(), getColor("#DA70D6"));
    cssColorMap.set("PaleGoldenRod".toLowerCase(), getColor("#EEE8AA"));
    cssColorMap.set("PaleGreen".toLowerCase(), getColor("#98FB98"));
    cssColorMap.set("PaleTurquoise".toLowerCase(), getColor("#AFEEEE"));
    cssColorMap.set("PaleVioletRed".toLowerCase(), getColor("#D87093"));
    cssColorMap.set("PapayaWhip".toLowerCase(), getColor("#FFEFD5"));
    cssColorMap.set("PeachPuff".toLowerCase(), getColor("#FFDAB9"));
    cssColorMap.set("Peru".toLowerCase(), getColor("#CD853F"));
    cssColorMap.set("Pink".toLowerCase(), getColor("#FFC0CB"));
    cssColorMap.set("Plum".toLowerCase(), getColor("#DDA0DD"));
    cssColorMap.set("PowderBlue".toLowerCase(), getColor("#B0E0E6"));
    cssColorMap.set("Purple".toLowerCase(), getColor("#800080"));
    cssColorMap.set("Red".toLowerCase(), getColor("#FF0000"));
    cssColorMap.set("RosyBrown".toLowerCase(), getColor("#BC8F8F"));
    cssColorMap.set("RoyalBlue".toLowerCase(), getColor("#4169E1"));
    cssColorMap.set("SaddleBrown".toLowerCase(), getColor("#8B4513"));
    cssColorMap.set("Salmon".toLowerCase(), getColor("#FA8072"));
    cssColorMap.set("SandyBrown".toLowerCase(), getColor("#F4A460"));
    cssColorMap.set("SeaGreen".toLowerCase(), getColor("#2E8B57"));
    cssColorMap.set("SeaShell".toLowerCase(), getColor("#FFF5EE"));
    cssColorMap.set("Sienna".toLowerCase(), getColor("#A0522D"));
    cssColorMap.set("Silver".toLowerCase(), getColor("#C0C0C0"));
    cssColorMap.set("SkyBlue".toLowerCase(), getColor("#87CEEB"));
    cssColorMap.set("SlateBlue".toLowerCase(), getColor("#6A5ACD"));
    cssColorMap.set("SlateGray".toLowerCase(), getColor("#708090"));
    cssColorMap.set("SlateGrey".toLowerCase(), getColor("#708090"));
    cssColorMap.set("Snow".toLowerCase(), getColor("#FFFAFA"));
    cssColorMap.set("SpringGreen".toLowerCase(), getColor("#00FF7F"));
    cssColorMap.set("SteelBlue".toLowerCase(), getColor("#4682B4"));
    cssColorMap.set("Tan".toLowerCase(), getColor("#D2B48C"));
    cssColorMap.set("Teal".toLowerCase(), getColor("#008080"));
    cssColorMap.set("Thistle".toLowerCase(), getColor("#D8BFD8"));
    cssColorMap.set("Tomato".toLowerCase(), getColor("#FF6347"));
    cssColorMap.set("Turquoise".toLowerCase(), getColor("#40E0D0"));
    cssColorMap.set("Violet".toLowerCase(), getColor("#EE82EE"));
    cssColorMap.set("Wheat".toLowerCase(), getColor("#F5DEB3"));
    cssColorMap.set("White".toLowerCase(), getColor("#FFFFFF"));
    cssColorMap.set("WhiteSmoke".toLowerCase(), getColor("#F5F5F5"));
    cssColorMap.set("Yellow".toLowerCase(), getColor("#FFFF00"));
    cssColorMap.set("YellowGreen".toLowerCase(), getColor("#9ACD32"));

    cssColorMap;
  }

  public static inline function getHexColor(hex: String): Int {
    return Std.parseInt(StringTools.replace(hex, "#", "0x"));
  }

  public static function getRGBAColor(color: String): Int {
    color = StringTools.replace(color, "rgba(", "");
    color = StringTools.replace(color, ")", "");
    var frags: Array<String> = color.split(",");
    return rgbToHex(Std.parseInt(frags[0]), Std.parseInt(frags[1]), Std.parseInt(frags[2]));
  }

  public static function getColor(color: String): Int {
    if(cssColorMap.exists(color)) {
      return cssColorMap.get(color);
    }
    if(StringTools.startsWith(color, "rgba")) {
      return getRGBAColor(color);
    }
    return getHexColor(color);
  }

  private static var hexCodes = "0123456789ABCDEF";

  public static function rgbToHex(r: Int, g: Int, b: Int): Int {
    var hexString = "0x";
    //Red
    hexString += hexCodes.charAt(Math.floor(r / 16));
    hexString += hexCodes.charAt(r % 16);
    //Green
    hexString += hexCodes.charAt(Math.floor(g / 16));
    hexString += hexCodes.charAt(g % 16);
    //Blue
    hexString += hexCodes.charAt(Math.floor(b / 16));
    hexString += hexCodes.charAt(b % 16);

    return Std.parseInt(hexString);
  }

  public static function rgbaToHex(r: Int, g: Int, b: Int, a: Int): Int {
    var hexString = "0x";
    //Red
    hexString += hexCodes.charAt(Math.floor(r / 16));
    hexString += hexCodes.charAt(r % 16);
    //Green
    hexString += hexCodes.charAt(Math.floor(g / 16));
    hexString += hexCodes.charAt(g % 16);
    //Blue
    hexString += hexCodes.charAt(Math.floor(b / 16));
    hexString += hexCodes.charAt(b % 16);
    //Alpha
    hexString += hexCodes.charAt(Math.floor(a / 16));
    hexString += hexCodes.charAt(a % 16);


    return Std.parseInt(hexString);
  }
}
