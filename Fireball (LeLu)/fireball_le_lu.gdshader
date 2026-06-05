shader_type spatial;
render_mode blend_mix, depth_draw_opaque, depth_test_default, cull_disabled, diffuse_lambert, specular_schlick_ggx, unshaded, shadows_disabled, ambient_light_disabled;

uniform vec4 fire_color: source_color;
uniform sampler2D alpha_noise;
uniform sampler2D subtraction;

uniform vec2 scroll_speed = vec2(1.);

void fragment() {
	ALBEDO.rgb = vec3(fire_color.xyz);
	
	vec2 scrolled_uv = UV + scroll_speed * TIME;
	
	ALPHA = clamp(texture(alpha_noise, scrolled_uv).r - texture(subtraction, UV).r, 0., 1.);
}

