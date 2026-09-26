//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_bloom_cutoff;
uniform float u_bloom_amount;

void main()
{
    vec4 sampled = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    //float brightness = (sampled.r + sampled.g + sampled.b) / 3.0;
    
    vec3 luma_weights = vec3(0.299, 0.587, 0.114);
    float brightness = dot(luma_weights, sampled.rgb);
    
    if (brightness < u_bloom_cutoff) {
        discard;
    }
    
    sampled.rgb *= u_bloom_amount;
    
    gl_FragColor = sampled;
}