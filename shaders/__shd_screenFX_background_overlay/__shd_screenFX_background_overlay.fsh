precision highp float;
precision highp int;

uniform float u_max_brightness; 
uniform float u_intensity;
uniform vec2 u_pos;
uniform vec2 u_offset;
uniform vec2 u_scale;
uniform sampler2D u_tex_replacement;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

#define PIXEL_CUTOFF 0.94000

void main()
{
	vec2 pixel = v_vTexcoord / u_scale;
 	vec4 colour = texture2D( gm_BaseTexture, v_vTexcoord );
    float grayscale_value = dot(colour.rgb, vec3(0.299, 0.587, 0.114));
	#ifdef _YY_GLSLES_
		vec2 pos = vec2(mod(pixel.x + u_pos.x, PIXEL_CUTOFF), mod(pixel.y + u_pos.y, PIXEL_CUTOFF));
	#else
		vec2 pos = u_pos;
	#endif
 
	float effect_factor = 1.0 - smoothstep(0.0, u_max_brightness, grayscale_value);
    colour.rgb += u_intensity * vec3(texture2D(u_tex_replacement, pixel + pos + u_offset).a) * effect_factor;
    gl_FragColor = v_vColour * colour;
}
