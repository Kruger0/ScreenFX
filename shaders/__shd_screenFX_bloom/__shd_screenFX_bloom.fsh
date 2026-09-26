uniform float u_bloom_start;
uniform float u_bloom_end;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	//float bloom = smoothstep(u_bloom_start, u_bloom_end, luma);
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
