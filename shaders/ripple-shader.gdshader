// Basado en: https://www.shadertoy.com/view/ldBXDD

shader_type canvas_item;

uniform float wave_count : hint_range(1.0, 20.0, 1.0) = 12.0;
uniform float speed : hint_range(0.0, 10.0, 0.1) = 4.0;
uniform float height : hint_range(0.0, 0.1, 0.001) = 0.03;


void fragment() {
    vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 fragCoord = UV * resolution;
    // pixel position normalised to [-1, 1]
	vec2 cPos = -1.0 + 2.0 * fragCoord.xy / resolution.xy;
    // distance of current pixel from center
	float cLength = length(cPos);
	vec2 uv = fragCoord.xy / resolution.xy + (cPos/cLength) * cos(cLength * wave_count - TIME * speed) * height;
    vec3 col = texture(TEXTURE, uv).xyz;
	COLOR = vec4(col,1.0);
}