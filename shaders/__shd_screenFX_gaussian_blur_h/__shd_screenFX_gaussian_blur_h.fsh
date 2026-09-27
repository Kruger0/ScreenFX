uniform vec2 u_texture_size;
uniform float u_blur_radius;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    vec2 texel = 1.0 / u_texture_size;
    
    vec4 total_color = vec4(0);
    
    for (float i = -u_blur_radius; i <= u_blur_radius; i += 1.0) {
        total_color += texture2D(gm_BaseTexture, v_vTexcoord + vec2(i, 0) * texel);
    }
    
    total_color /= 2.0 * u_blur_radius + 1.0;
    
    gl_FragColor = v_vColour * total_color;
}