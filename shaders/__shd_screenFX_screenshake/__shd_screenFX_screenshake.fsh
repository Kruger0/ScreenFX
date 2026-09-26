//
// Simple passthrough fragment shader
//
uniform vec2 u_surface_resolution;

uniform sampler2D u_noise_texture;
uniform vec2 u_noise_resolution;
uniform float u_magnitude;
uniform float u_shake_speed;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec2 noise2D(vec2 _in)
{
	return texture2D( u_noise_texture, _in ).xy;
}

void main()
{
	vec2 noiseCoords;
	noiseCoords.x = fract((u_shake_speed * 60.0) / u_noise_resolution.x);	
	noiseCoords.y = 0.5 / u_noise_resolution.y;
	
	vec2 offset = noise2D(noiseCoords);
	offset = ((offset - 0.5) * 2.0 * u_magnitude) / u_surface_resolution;	
	
	gl_FragColor = texture2D( gm_BaseTexture, v_vTexcoord + offset);
}