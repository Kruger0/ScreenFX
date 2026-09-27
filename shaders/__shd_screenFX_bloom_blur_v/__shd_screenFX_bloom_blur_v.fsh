uniform float u_bloom_size;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	float alpha =  texture2D(gm_BaseTexture, v_vTexcoord).a;
    vec2 texel_size = vec2(dFdx(v_vTexcoord.x), dFdy(v_vTexcoord.y));
    
    vec3 value = vec3(0);
    float samples = 2.0 * u_bloom_size + 1.0;
    
    for (float i = -u_bloom_size; i <= u_bloom_size; i += 1.0) {
        vec2 offset = vec2(0.0, i) * texel_size;
        vec3 neighbor = texture2D(gm_BaseTexture, v_vTexcoord + offset).rgb;
        value += neighbor;
    }
    
    value /= samples;
    
    gl_FragColor = vec4(value, alpha);
}