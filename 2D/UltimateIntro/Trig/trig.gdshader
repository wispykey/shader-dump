shader_type canvas_item;

uniform sampler2D scale_curve;

void vertex() {
	float normalized_curve = 0.5 * (1. + sin(TIME));
	normalized_curve = fract(TIME);
	float curve_output = texture(scale_curve, vec2(normalized_curve, 0.)).r;
	VERTEX *= curve_output * 2.;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

