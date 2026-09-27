uniform float u_bloom_cutoff;
uniform float u_bloom_amount;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 sampled = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );

    vec3 luma_weights = vec3(0.299, 0.587, 0.114);
    float brightness = dot(luma_weights, sampled.rgb);
    
    if (brightness < u_bloom_cutoff) {
        discard;
    }
    
    sampled.rgb *= u_bloom_amount;
    
    gl_FragColor = sampled;
}