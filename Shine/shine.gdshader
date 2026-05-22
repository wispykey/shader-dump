shader_type canvas_item;

uniform sampler2D scale_curve;


void fragment() {
	vec2 uv = UV;
	
	float normalized_curve = fract(TIME);
	// Use a curve to manage a normalized x value
	float curve_output = texture(scale_curve, vec2(normalized_curve, 0.)).r;
	// This only works because we're strictly using the diagonal line y=x 
	float line = curve_output + curve_output;
	
	float shine = step(distance(line, uv.x + uv.y), 0.1);
	
	COLOR.rgb = mix(COLOR.rgb, vec3(1), shine);
}