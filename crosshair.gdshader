shader_type canvas_item;

uniform float center_size: hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float ring_distance: hint_range(0.0, 1.0) = 0.5;
uniform float ring_width: hint_range(0.0, 1.0) = 0.5;
uniform float cutout_width: hint_range(0.0, 1.0) = 0.5;
uniform float line_width: hint_range(0.0, 1.0) = 0.5;
uniform float line_length: hint_range(0.0, 1.0) = 0.5;
uniform float line_position: hint_range(0.0, 1.0) = 1.0;

float create_circles(vec2 uv) {
	
	float circle = step(distance(uv, vec2(0.5)), center_size * 0.1);
	float outer_circle = step(distance(uv, vec2(0.5)), 0.5*ring_distance);
	float inner_circle = step(distance(uv, vec2(0.5)), 0.5*ring_distance - ring_width * 0.1);
	
	float cross_cutout = min(step(distance(uv.x, 0.5), cutout_width * 0.2) + step(distance(uv.y, 0.5), cutout_width * 0.2), 1.);

	return max(outer_circle - inner_circle - cross_cutout, 0.) + circle;
}

float create_lines(vec2 uv) {
	float line_thickness = 0.15;
	float width_modifier = 0.15;
	float lines = min(step(distance(uv.x, 0.5), width_modifier * line_width * line_thickness) + step(distance(uv.y, 0.5), width_modifier * line_width * line_thickness), 1);
	
	float local_line_length = line_length * 2.;
	float offset = line_position * 0.2;
	float center_cutout = step(distance(uv, vec2(0.5)), offset);
	float perimeter_cutout = step(offset + local_line_length * line_thickness, distance(uv, vec2(0.5)));
	
	return max(lines - center_cutout - perimeter_cutout, 0);
}

void fragment() {
	COLOR.rgb = vec3(1.);
	COLOR.a = max(create_circles(UV), create_lines(UV));
	
}
