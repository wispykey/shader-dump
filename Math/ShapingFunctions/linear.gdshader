shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR.a = 1.;
	
	// Redundantly formatted as 'y = mx + b' for clarity
	float expected_y_given_x = -1.*UV.x + 1.;
	// The above value is the expected value of y for the current fragment's x
	float dist_to_line = abs(UV.y - expected_y_given_x);
	
	// The mix function represents what I commonly want to do
	// 'if step function meets criteria use color a; else use color b'
	// It is unintuitive because I am 'abusing' interpolation for only two values
	float line_or_gradient = 1. - step(0.01, dist_to_line);
	COLOR.rgb = mix(vec3(UV.x), vec3(0., 1., 0.), line_or_gradient);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
