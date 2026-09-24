#ifdef _YY_GLSL_
precision mediump float;
precision mediump int;
#endif

uniform vec2 u_resolution;
uniform float u_amount;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    float d = 1.0 / u_amount;
	float ar = u_resolution.x / u_resolution.y;
	float u = floor(v_vTexcoord.x / d) * d;

	d = ar / u_amount;

	float v = floor(v_vTexcoord.y / d) * d;

	gl_FragColor = v_vColour * texture2D( gm_BaseTexture, vec2(u, v) );
}