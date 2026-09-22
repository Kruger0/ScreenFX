varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_Saturation;

void main() {
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    vec3 grayScale = vec3(gray);
    vec3 result = mix(grayScale, color.rgb, u_Saturation);

    gl_FragColor = vec4(result, color.a);
}