// from: https://www.shadertoy.com/view/XsXXDn

shader_type canvas_item;

void fragment() {
    // Obtener la resolución de la ventana
    //vec2 resolution = vec2(1280.0, 720.0); // Ajusta estos valores según la resolución de tu proyecto
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;

    // Calcular el tamaño de un píxel en pantalla
    vec2 pixel_size = 1.0 / resolution;

    // Calcular las coordenadas normalizadas del píxel
    vec2 p = FRAGCOORD.xy * pixel_size - 0.5;
    p.x *= resolution.x / resolution.y;

    // Inicializar variables
    float l, z = TIME;
    vec3 c = vec3(0.0);

    // Bucle para calcular el color en función de las coordenadas
    for (int i = 0; i < 3; i++) {
        vec2 uv = p;
        z += 0.07;
        l = length(p);
        uv += p / l * (sin(z) + 1.0) * abs(sin(l * 9.0 - z - z));
        c[i] = 0.01 / length(mod(uv, 1.0) - 0.5);
    }

    // Asignar el color final
    COLOR = vec4(c / l, TIME);
}
