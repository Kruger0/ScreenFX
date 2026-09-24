varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 u_rgba;
uniform float u_mix;

void main()
{
	vec4 finalColour = mix(v_vColour, u_rgba, u_mix);
    gl_FragColor = finalColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
