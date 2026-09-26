uniform float u_contrast;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	colour.rgb = (colour.rgb - 0.5) * u_contrast + 0.5;
	gl_FragColor = colour;
}
