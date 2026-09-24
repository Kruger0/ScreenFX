varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_posterizationLevel;

void main() {
    vec4 base = texture2D(gm_BaseTexture, v_vTexcoord);
    
    float gray = max(base.r, max(base.g, base.b));
    float lower = floor(gray * u_posterizationLevel) / u_posterizationLevel;
    float upper = ceil(gray * u_posterizationLevel) / u_posterizationLevel;
    float lower_diff = gray - lower;
    float upper_diff = upper - gray;
    
    float level = (lower_diff <= upper_diff) ? lower : upper;
    float adjustment = level / gray;
    
    base.rgb *= adjustment;
    
    
    gl_FragColor = v_vColour * base;
}