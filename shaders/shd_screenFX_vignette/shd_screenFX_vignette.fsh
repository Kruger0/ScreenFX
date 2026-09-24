uniform float u_Amount;
uniform float u_Falloff;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );

    float dist = distance(v_vTexcoord, vec2(0.5, 0.5));
    color.rgb *= smoothstep(0.8, u_Falloff * 0.799, dist * (u_Amount + u_Falloff));

    gl_FragColor = color;
}