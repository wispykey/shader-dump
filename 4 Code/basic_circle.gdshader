shader_type canvas_item;

uniform float size: hint_range(0.0, 0.5, 0.01);
uniform vec3 color: source_color;

void fragment() {
	
	float circle = distance(UV, vec2(0.5));
	COLOR.a = step(circle, size);
	COLOR.rgb = color;

}
