shader_type canvas_item;

uniform float negative_exponent: hint_range(0., 100., 1.) = 1.;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR.a = 1.;
	
	float exponent = -UV.x * negative_exponent;
	vec3 gradient = vec3(exp(exponent));
	float expected_y_given_x = 1. - exp(exponent);
	
	float curve_mask = 1. - step(0.01, abs(distance(UV.y, expected_y_given_x)));
	
	COLOR.rgb = mix(gradient, vec3(0., 1., 0.), curve_mask);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
