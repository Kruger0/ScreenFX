varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_opacity;
uniform float u_mix;

uniform sampler2D u_diffuse;

void main()
{
	vec4 texel1 = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 texel2 = texture2D(u_diffuse, v_vTexcoord);
	texel2.a *= u_opacity;

    vec4 result;
    result.rgb = mix(texel1.rgb, texel2.rgb, texel2.a);
    result.a   = texel2.a + texel1.a * (1.0 - texel2.a);
    gl_FragColor = result * v_vColour;
}
