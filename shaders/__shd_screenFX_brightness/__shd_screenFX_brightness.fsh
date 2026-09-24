uniform float u_brightness;
uniform float u_contrast;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 colour = texture2D( gm_BaseTexture, v_vTexcoord );
	colour.rgb = mix(vec3(0.5), colour.rgb + u_brightness - 1.0, u_contrast);
	gl_FragColor = v_vColour * colour;
}
