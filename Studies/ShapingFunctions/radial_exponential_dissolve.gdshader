shader_type canvas_item;

uniform sampler2D icon: repeat_enable;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 centered_uv = (UV - 0.5) * 2.;
	
	COLOR.a = 1.;
	COLOR.rgb = texture(icon, centered_uv).rgb;
	
	float dissolve_time = 1. - exp(-3. * fract(TIME));
	
	// smoothstep effective range is the gradient range, NOT the entire circle
	// it's just the 'border' of the dissolve
	// larger range is more blurred and more 'pillowy'
	float circle = smoothstep(0. + dissolve_time, 0.3 + dissolve_time, distance(UV, vec2(0.5)));
	
	COLOR.a = circle;	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
