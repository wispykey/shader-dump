shader_type spatial;

uniform sampler2D flame;
uniform sampler2D color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec4 color_at_flame_texture_UV = texture(flame, UV);
	
	
	vec4 sampled_color = texture(color, vec2(color_at_flame_texture_UV.r));
	
	//ALBEDO.rgb = sampled_color.rgb;
	ALBEDO.rgb = sampled_color.rgb;
	ALPHA = color_at_flame_texture_UV.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
