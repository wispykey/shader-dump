shader_type spatial;
render_mode blend_mix, depth_draw_opaque, depth_test_default, cull_disabled, diffuse_lambert, specular_schlick_ggx, unshaded, shadows_disabled, ambient_light_disabled;

uniform vec4 ball_color: source_color;
uniform float fresnel_power = 4.;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float a = pow(clamp(dot(NORMAL, VIEW), 0.0, 1.0), fresnel_power);

	ALBEDO.rgb = ball_color.rgb;
	ALPHA = a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
