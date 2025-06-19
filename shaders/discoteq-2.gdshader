// Basado en: https://www.shadertoy.com/view/DtXfDr

shader_type canvas_item;

uniform vec4 LineColor : source_color = vec4(0.9, 0.6, 0.3, 1.0);

vec4 Line(vec2 uv, float speed, float height, vec3 col) {
	uv.y += smoothstep(1., 0., abs(uv.x)) * sin(TIME * speed + uv.x * height) * .2;
	return vec4(smoothstep(.06 * smoothstep(.2, .9, abs(uv.x)), 0., abs(uv.y) - .004) * col, 1.0) * smoothstep(1., .3, abs(uv.x));
}

void fragment() {
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 fragCoord = UV * resolution;

	vec2 uv = (fragCoord.xy - resolution.xy * 0.5) / resolution.y;

	for (float i = 0.; i <= 5.; i += 1.) {
		float t = i / 5.;
		vec3 color_variant = vec3(t * .7, t * .4, 0.3);
		vec3 color_user = LineColor.rgb;
		vec3 color = color_user + color_variant;
        COLOR += Line(uv, 1. + t, 4. + t, color);

		// Otra forma de calcular el color:
		//vec3 base = LineColor.rgb;
		//vec3 modulated = base * (0.5 + 0.5 * t); // O ajusta el rango que prefieras
		//COLOR += Line(uv, 1.0 + t, 4.0 + t, modulated);
    }
}

