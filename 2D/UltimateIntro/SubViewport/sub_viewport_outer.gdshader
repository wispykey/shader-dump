shader_type canvas_item;

uniform float line_count: hint_range(1., 50.0, 1.) = 20.;
uniform float line_width: hint_range(0.1, 1.) = 0.5;

uniform float speed: hint_range(0., 1.) = 0.5;

uniform float wobble_speed: hint_range(0.1, 1.) = 0.5;
uniform float frequency_y: hint_range(0.1, 1.) = 0.5;
uniform float amplitude_y: hint_range(0.1, 1.) = 0.5;

vec3 hsv2rgb(float hue) {
	vec3 k = vec3(1., 2./3., 1./3.);
	vec3 p = abs(fract(vec3(hue) + k) * 6. - 3.);
	return clamp(p - vec3(1.), 0, 1.);
}


void vertex() {
	// Called for every vertex the material is visible on.
	
	//VERTEX.x += sin(VERTEX.y * 10.) * 20.;
	
		
	VERTEX.x += sin((-TIME * wobble_speed + UV.y * 2.) * frequency_y * 20.) * amplitude_y * 50.;
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 pixel_uv = floor(UV * 120.) / 120.;
	float diagonal_pos = pixel_uv.x + pixel_uv.y;
	float moving_pos = diagonal_pos - (TIME * speed);
	
	float pattern = fract(moving_pos * line_count * speed);
	
	vec3 rainbow = hsv2rgb(moving_pos);
	
	float is_line = float(pattern < line_width);
	
	COLOR.rgb = mix(COLOR.rgb, rainbow, is_line);
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
