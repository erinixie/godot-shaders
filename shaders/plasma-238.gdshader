/*
Basado en: https://www.shadertoy.com/view/WfS3Dd
"Plasma" by @XorDev
*/
shader_type canvas_item;

void fragment() {
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 fragCoord = UV * resolution;

	// Invierte en el eje Y
	fragCoord.y = resolution.y - fragCoord.y;
	// Invierte en el eje X
	//fragCoord.x = resolution.x - fragCoord.x;

	// Coordenadas centradas y con corrección de proporción
	vec2 uv = (fragCoord * 2.0 - resolution) / resolution.y;

	// Profundidad z (usada para distorsión)
	vec2 z = vec2(0.0);

	// Contador de iteraciones
	vec2 i = vec2(0.0);

	// Distorsión basada en la posición
	float distortion = 4.0 - 4.0 * abs(0.7 - dot(uv, uv));
	z += distortion;

	// Coordenadas del fluido
	vec2 fluid = uv * z;

	// Inicializar color final
	vec4 fragColor = vec4(0.0);

	// Simular 8 iteraciones de movimiento del fluido
	for (int j = 0; j < 8; j++) {
		i.y += 1.0;

		// Ondas del fluido usando seno y coseno + tiempo
		fluid += cos(fluid.yx * i.y + i + TIME) / i.y + 0.7;

		// Color generado a partir de ondas sinusoidales
		vec2 wave = sin(fluid) + 1.0;
		vec4 waveColor = vec4(wave.x, wave.y, wave.y, 1.0);
		waveColor *= abs(fluid.x - fluid.y);

		// Acumular color
		fragColor += waveColor;
	}

	// Aplicar tono, desvanecimiento en bordes y gradiente de color
	vec4 edgeGradient = vec4(-1.0, 1.0, 2.0, 0.0);
	vec4 fade = exp(z.x - 4.0 - uv.y * edgeGradient);
	fragColor = tanh(7.0 * fade / fragColor);

	// Salida final del fragmento
	COLOR = fragColor;
}