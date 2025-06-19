// Basado en: https://www.shadertoy.com/view/XtfcWH

shader_type canvas_item;

const float side = 0.3;
const float angle = PI*1.0/3.0;
const float sinA = 0.86602540378;
const float cosA = 0.5;
const vec3 zero = vec3(0.0);
const vec3 one = vec3(1.0);

// generates the colors for the rays in the background
vec4 rayColor(vec2 fragToCenterPos, vec2 fragCoord) {
	float d = length(fragToCenterPos);
	fragToCenterPos = normalize(fragToCenterPos);
		
	float multiplier = 0.0;
	const float loop = 60.0;
	const float dotTreshold = 0.90;
	const float timeScale = 0.75;
	const float fstep = 10.0;
	
	// generates "loop" directions, summing the "contribution" of the fragment to it. (fragmentPos dot direction)
	float c = 0.5/(d*d);
	float freq = 0.25;		
	for (float i = 1.0; i < loop; i++) {
		float attn = c;
		attn *= 1.85*(sin(i*0.3*TIME)*0.5+0.5);
		float t = TIME*timeScale - fstep*i;
		vec2 dir = vec2(cos(freq*t), sin(freq*t));
		float m = dot(dir, fragToCenterPos);
		m = pow(abs(m), 4.0);
		m *= float((m) > dotTreshold);
		multiplier += 0.5*attn*m/(i);
	}

	float f = abs(cos(TIME/2.0));
	
	const vec4 rayColor = vec4(0.9, 0.7, 0.3, 1.0);
		
	float pat = abs(sin(10.0*mod(fragCoord.y*fragCoord.x, 1.5)));
	f += pat;
	vec4 color = f*multiplier*rayColor;
	return color;
}

void fragment() {
    vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 fragCoord = UV * resolution;
	
	float aspect = resolution.x / resolution.y;
	vec3 pos = vec3(fragCoord.xy / resolution.xy, 1.0);
	pos.x *= aspect;
	
	vec2 fragToCenterPos = vec2(pos.x - 0.5*aspect, pos.y - 0.5);
	vec4 rayCol = rayColor(fragToCenterPos,fragCoord);
	
	float u, v, w;
	float c = 0.0;	

	vec4 triforceColor = vec4(1.0);
	COLOR = mix(rayCol, triforceColor, c);
}
