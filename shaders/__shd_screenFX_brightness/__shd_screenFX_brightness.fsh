uniform float u_brightness;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);

	gl_FragColor = vec4(colour.rgb + u_brightness, colour.a);
}
