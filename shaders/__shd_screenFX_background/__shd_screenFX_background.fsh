uniform float u_max_brightness; 
uniform float u_intensity;
uniform vec2 u_pos;
uniform vec2 u_offset;
uniform vec2 u_scale;
uniform sampler2D u_tex_replacement;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec2 pixel = v_vTexcoord / u_scale;
 	vec4 colour = texture2D( gm_BaseTexture, v_vTexcoord );
    float grayscale_value = dot(colour.rgb, vec3(0.299, 0.587, 0.114));

 
float effect_factor = 1.0 - smoothstep(
    0.0,
    u_max_brightness,
    grayscale_value
);
    colour.rgb += u_intensity * vec3(texture2D(u_tex_replacement, pixel + u_pos + u_offset).a) * effect_factor;
    gl_FragColor = v_vColour * colour;
}
