//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 u_Rgba;
uniform float u_Mix;

void main()
{
	vec4 finalColour = mix(v_vColour, u_Rgba, u_Mix);
    gl_FragColor = finalColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
