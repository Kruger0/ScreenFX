uniform vec4 u_tone;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() 
{
    vec4 colour = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    float gray = dot(colour, vec4(0.2126, 0.7152, 0.0722, 0));
    vec4 shade = vec4(gray * u_tone.rgb, colour.a);

    gl_FragColor = mix(shade, colour, u_tone.a);
}