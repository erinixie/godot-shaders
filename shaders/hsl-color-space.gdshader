// Basado en: https://www.shadertoy.com/view/4sS3Dc

shader_type canvas_item;

// Convert HSL colorspace to RGB. http://en.wikipedia.org/wiki/HSL_and_HSV
vec3 HSLtoRGB(in vec3 c) {
	vec3 rgb = clamp(abs(mod(c.x+vec3(0.,4.,2.),6.)-3.)-1.,0.,1.);
	return c.z+c.y*(rgb-0.5)*(1.-abs(2.*c.z-1.));
}

vec3 HSL2RGB_CubicSmooth(in vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x+vec3(0.,4.,2.),6.)-3.)-1.,0.,1.);
    rgb = rgb*rgb*(3.0-2.0*rgb); // iq's cubic smoothing.
    return c.z+ c.y*(rgb-0.5)*(1.-abs(2.*c.z-1.));
}

void fragment() {
    vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 fragCoord = UV * resolution;

	vec2 uv = (-1.+2.*fragCoord.xy/resolution.xy) * vec2(resolution.x/resolution.y,1.);
	
	float fAngle = TIME*0.4;
	float h = atan(uv.x,uv.y) - fAngle;
	float x = length(uv);
	float a = -(0.6+0.2*sin(TIME*3.1+sin((TIME*0.8+h*2.0)*3.0))*sin(TIME+h));
	float b = -(0.8+0.3*sin(TIME*1.7+sin((TIME+h*4.0))));
	float c = 1.25+sin((TIME+sin((TIME+h)*3.0))*1.3)*0.15;
	float l = a*x*x + b*x + c;
	//vec3 hsl_standard = HSLtoRGB(vec3(h*3./PI,1.,l));
	vec3 hsl_cubic = HSL2RGB_CubicSmooth(vec3(h*3.0/PI,1.,l));
	COLOR = vec4(hsl_cubic,1.0);
}




