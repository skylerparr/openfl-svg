package shaders;
import openfl.display.DisplayObjectShader;
class BitmapMaskShader extends DisplayObjectShader {


    @:glFragmentSource("

		#pragma header

		uniform sampler2D maskImage;

		void main(void) {

			#pragma body

            vec4 pixel = texture2D (maskImage, openfl_TextureCoordv);
            if(pixel.x == 0.0 && pixel.y == 0.0 && pixel.z == 0.0) {
                float mask = pixel.a;
                gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
            } else {
                float mask = pixel.a;
                gl_FragColor *= mask;
            }

		}

	")

    public function new() {

        super();

    }


}