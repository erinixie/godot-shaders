shader_type canvas_item;

float circle(vec2 uv, float blur) {
	return smoothstep(0., blur, 1. - length(uv));
}

void fragment() {
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 fragCoord = UV * resolution;
	vec2 uv = (fragCoord.xy - resolution.xy * 0.5) / resolution.y;
    
	float circleWhite = circle(uv * 2.45, 1.);
	float circleBlack = circle(uv * 2.86, 0.7);
	float c = circleWhite - circleBlack;
	c *= 6.;
    
	float t = TIME * 5.;
	c -= circle(vec2(uv.x - sin(t) * .85, 1.8*uv.y - cos(t) * .65) * .8, 1.); 
    
	vec3 col = vec3(c) * vec3(1., 0., 0.5);
	col += vec3(smoothstep(0.2, 0.7, c)) * vec3(1., 1., 0.);
	col += vec3(smoothstep(0.4, 0.55, c));
    
	COLOR = vec4(col,1.0);
}