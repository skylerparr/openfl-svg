package util;
class MathUtil {
    public function new() {
    }

    /**
     * Convert degrees to radians.
     *
     * @param deg The number of degrees
     * @return The number of radians (between 0 and  2π)
     *
     */
    public static inline function degreesToRadians( deg: Float ): Float {
        return ( deg * Math.PI / 180.0 );
    }

    /**
     * Convert radians to degrees.
     *
     * @param rad The number of radians
     * @return The number of degrees (between 0 and 360)
     *
     */
    public static inline function radiansToDegrees( rad: Float): Float {
        return ( rad * 180.0 / Math.PI );
    }
}
