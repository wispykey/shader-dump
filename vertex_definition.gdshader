shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX += vec2(50, 0) * step(0.5, UV.y);
}

void fragment() {
	float y_pos = step(0.5, UV.y);
	COLOR.rgb = vec3(y_pos);
}
