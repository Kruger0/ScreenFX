vec3 rgb(float h, float s, float v)
{
    //Compute RGB hue
    vec3 RGB = clamp(abs(mod(h*6.0+vec3(0,4,2), 6.0)-3.0)-1.0, 0.0, 1.0);
    //Multiply by value and mix for saturation
    return v * mix(vec3(1), RGB, s);
}

uniform vec3 u_hsv;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 colour = texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 rgba = vec4(rgb(u_hsv.r, u_hsv.g, u_hsv.b), 1.0);
    gl_FragColor = v_vColour * colour * rgba;
}
