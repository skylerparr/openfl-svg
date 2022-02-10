package util;

class ClassUtil {

  public static function classToClassName(clazz: Class<Dynamic>): String {
    var className = Type.getClassName(clazz);
    var frags = className.split(".");
    return frags[frags.length - 1];
  }

  public static function createInstance(className:String, args: Array<Dynamic> = null):Dynamic {
    if(args == null) {
      args = [];
    }
    return Type.createInstance(stringToClass(className), args);
  }

  public static function createInstanceFromClass(clazz:Class<Dynamic>, args: Array<Dynamic> = null):Dynamic {
    if(args == null) {
      args = [];
    }
    return Type.createInstance(clazz, args);
  }

  public static function stringToClass(className: String): Class<Dynamic> {
    return Type.resolveClass(className);
  }
}