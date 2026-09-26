precision highp float;
precision highp int;

uniform float u_samples;
uniform float u_contrast;
uniform vec2 u_offset;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

#define SAMPLES_WEBGL 20.0

void main()
{
	vec4 colour_sum = vec4(0);
	vec4 weight_sum = vec4(0);
	
	for(float i = 0.0; i<=1.0; i+=1.0/SAMPLES_WEBGL)
	{
	    vec2 coord = mix(v_vTexcoord, vec2(0.5), (i-0.5) * u_offset);
	    vec4 colour = texture2D(gm_BaseTexture, coord);
	    vec4 weight = vec4(i, 1.0 - abs(i*2.0 - 1.0), 1.0 - i, 0.5);
		weight = mix(vec4(0.5), weight, u_contrast);
	
		colour_sum += colour * colour * weight;
	    weight_sum += weight;
	}
	
	gl_FragColor = v_vColour * sqrt(colour_sum / weight_sum);
}
