varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_flow_map; 
uniform float u_strength;
uniform float u_speed;      
uniform int u_frames; 
uniform float u_time;

float clock(float time){
	float frames = float(u_frames);
	return floor(mod(time * u_speed, frames)) / frames;
}

void main()
{
	float time = clock(u_time);
	vec4 offset = texture2D(u_flow_map, vec2(v_vTexcoord.x + time, v_vTexcoord.y + time)) * u_strength; 
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord.xy + offset.xy - (vec2(0.5,0.5)*u_strength));
}
