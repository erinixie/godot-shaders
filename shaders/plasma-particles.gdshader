// Basado en: https://www.shadertoy.com/view/MlfcDN

shader_type canvas_item;

float noise(vec2 co){
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 fragCoord = UV * resolution;
	vec2 uv = fragCoord.xy / resolution.xy;
    
    float u_brightness = 1.2;
    float u_blobiness = 0.9;
    float u_particles = 140.0;
    float u_limit = 70.0;
    float u_energy = 1.0 * 0.75;

    vec2 position = (fragCoord.xy / resolution.x);
    float t = TIME * u_energy;
    
    float a = 0.0;
    float b = 0.0;
    float c = 0.0;

    vec2 pos;
    vec2 center = vec2(0.5, 0.5 * (resolution.y / resolution.x));

    float na, nb, nc, nd, d;
    float limit = u_particles / u_limit;
    float step = 1.0 / u_particles;
    float n = 0.0;
    
    for (float i = 0.0; i <= 1.0; i += 0.025) {
        if (i <= limit) {
            vec2 np = vec2(n, 1.0-1.0);
            
            na = noise(np * 1.1);
            nb = noise(np * 2.8);
            nc = noise(np * 0.7);
            nd = noise(np * 3.2);

            pos = center;
            pos.x += sin(t*na) * cos(t*nb) * tan(t*na*0.15) * 0.3;
            pos.y += tan(t*nc) * sin(t*nd) * 0.1;
            
            d = pow(1.6*na / length(pos - position), u_blobiness);
            
            if (i < limit * 0.3333) a += d;
            else if (i < limit * 0.5) b += d;
            else c += d;

            n += step;
        }
    }

    vec3 col = vec3(a*25.5,0.0,a*b) * 0.0001 * u_brightness;
    COLOR = vec4( col, 1.0 );
}
