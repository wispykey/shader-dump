shader_type canvas_item;

uniform float speed: hint_range(0.1, 10.0, 0.1) = 5.;

void fragment() {
	float diagonal = (UV.x + UV.y) / 2.;
	float threshold = sin(TIME * speed);
	
	COLOR.a = step(threshold, diagonal) * texture(TEXTURE, UV).a;
}
