shader_type spatial;
render_mode cull_disabled, unshaded, shadows_disabled, ambient_light_disabled, fog_disabled, specular_schlick_ggx, depth_draw_opaque;

uniform sampler2D trail_texture;
uniform vec2 scroll_speed = vec2(1.);
uniform sampler2D color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	vec2 scrolled_uv = UV + TIME * scroll_speed;
	
	vec4 color_sample = texture(color, UV);
	ALBEDO = color_sample.rgb;
	ALPHA = texture(trail_texture, scrolled_uv).r * color_sample.a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
