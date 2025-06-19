// Basado en: https://www.shadertoy.com/view/tcVSDR

shader_type canvas_item;

void fragment() {
    vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 fragCoord = UV * resolution;

    // Position & Aspect ratio
    float aspect = resolution.x / resolution.y;
    vec2 uv = fragCoord / resolution.xy;
    uv.x *= aspect;
    vec2 center = vec2(0.5 * aspect, 0.5);

    float dist = length(uv - center);

    // Modulate UV with distance from center & time
    // uv += cos(dist * 10. - TIME) * (cos(TIME) + .5);
	// Se invierte el eje Y con: vec2(1.0, -1.0)
	uv += vec2(1.0, -1.0) * cos(dist * 10. - TIME) * (cos(TIME) + .5);

	// Brightness inversely proportional to distance from center
    vec3 c = vec3(.01 / length(uv - center)) / dist;

    COLOR = vec4(c, 1.);
}