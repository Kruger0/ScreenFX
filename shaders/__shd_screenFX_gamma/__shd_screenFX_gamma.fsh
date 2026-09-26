uniform float u_gamma;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec3 LinearToSRGB(vec3 input_rgb)
{
     return pow(input_rgb, vec3(1.0 / u_gamma));
}

void main()
{
	vec4 colour = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	colour.rgb = LinearToSRGB(colour.rgb);
	gl_FragColor = colour;
}
