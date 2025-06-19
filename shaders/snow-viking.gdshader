// Basado en: https://www.shadertoy.com/view/4dSfWV

shader_type canvas_item;

uniform float Layers : hint_range(0, 200) = 50;
uniform float Depth : hint_range(0, 2) = 0.5;
uniform float Width : hint_range(0, 1) = 0.3;
uniform float Speed : hint_range(0, 50) = 0.6;

/*
Examples:
  - LIGHT_SNOW: Layers 50; Depth 0.5; Width 0.3; Speed 0.6
  - BLIZZARD: Layers 200; Depth 0.1; Width 0.8; Speed 1.5
*/

void fragment() {
    vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 fragCoord = UV * resolution;
	vec2 uv = (fragCoord.xy - resolution.xy * 0.5) / resolution.y;
    
	// Simular mat3 usando 3 vec3 como filas o columnas
	vec3 p0 = vec3(13.323122, 23.5112, 21.71123);
	vec3 p1 = vec3(21.1212, 28.7312, 11.9312);
	vec3 p2 = vec3(21.8112, 14.7212, 61.3934);
	
	vec3 acc = vec3(0.0);
	float dof = 5.0 * sin(TIME * 0.1);

	for (float i = 0.0; i < Layers; i++) {
		float fi = float(i);
		vec2 q = uv * (1.0 + fi * Depth);
		q += vec2(q.y * (Width * mod(fi * 7.238917, 1.0) - Width * 0.5),
		          - Speed * TIME / (1.0 + fi * Depth * 0.03));
		
		vec3 n = vec3(floor(q), 31.189 + fi);
		vec3 m = floor(n) * 0.00001 + fract(n);

		// Multiplicación p * m sin usar mat3
		vec3 pm = vec3(
			dot(p0, m),
			dot(p1, m),
			dot(p2, m)
		);

		vec3 mp = (31415.9 + m) / fract(pm);
		vec3 r = fract(mp);

		vec2 s = abs(mod(q, 1.0) - 0.5 + 0.9 * r.xy - 0.45);
		s += 0.01 * abs(2.0 * fract(10.0 * q.yx) - 1.0);

		float d = 0.6 * max(s.x - s.y, s.x + s.y) + max(s.x, s.y) - 0.01;
		float edge = 0.005 + 0.05 * min(0.5 * abs(fi - 5.0 - dof), 1.0);
		acc += vec3(smoothstep(edge, -edge, d) * (r.x / (1.0 + 0.02 * fi * Depth)));
	}

	COLOR = vec4(acc, 1.0);
}