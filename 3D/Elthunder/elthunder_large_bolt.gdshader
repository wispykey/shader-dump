// NOTE: Shader automatically converted from Godot Engine 4.6.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_burley, specular_schlick_ggx, unshaded;

uniform sampler2D color_gradient: repeat_disable;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap;
uniform ivec2 albedo_texture_size;
uniform float point_size : hint_range(0.1, 128.0, 0.1);

uniform float flip_speed: hint_range(0., 1., 0.01) = 1.;
uniform float current_lifetime: hint_range(0., 1.) = 0.;

uniform float uv_x_scale = 1.;
uniform float uv_y_scale = 1.;
uniform float alpha_cutoff_threshold =  0.005;

void vertex() {
	// Vertex Color is sRGB: Enabled
	if (!OUTPUT_IS_SRGB) {
		COLOR.rgb = mix(
				pow((COLOR.rgb + vec3(0.055)) * (1.0 / (1.0 + 0.055)), vec3(2.4)),
				COLOR.rgb * (1.0 / 12.92),
				lessThan(COLOR.rgb, vec3(0.04045)));
	}
	
	float base_multiplier = 1.5 * 1.6;
	float step1 = step(0.15, fract(current_lifetime)) * .6;
	float step2 = step(0.25, fract(current_lifetime)) * .3;
	//float flip = mix(-1., 1., step(current_lifetime, 0.5)) * floor(sin(TIME * flip_speed * 32.)) + ceil(sin(TIME * flip_speed * 32.));
	float flip = 1.;

	float total_multiplier = flip * (base_multiplier - step1 - step2);
	VERTEX.x *= total_multiplier * 1.5 * (1. - pow(UV.y, 2));
	VERTEX.z *= total_multiplier * 1.5 * (1. -  pow(UV.y, 2));
	VERTEX.y *= base_multiplier;
	
	UV.x *= (uv_x_scale);
	UV.y *= uv_y_scale;
}

void fragment() {
	vec4 albedo_tex = texture(texture_albedo, UV);

	float t = albedo_tex.r;
	vec4 gradient_sample = texture(color_gradient, vec2(t));

	ALBEDO = gradient_sample.rgb;
	
	float segment1 = (1. - step(0.25, UV.y)) * step(0.02, fract(current_lifetime));
	float segment2 = (1. - step(0.5, UV.y)) * step(0.1, fract(current_lifetime));
	float segment3 = step(0.16, fract(current_lifetime));
	
	float lightning_mask = 1. - step(albedo_tex.r, alpha_cutoff_threshold);
	float lightning = smoothstep(0., 1., lightning_mask);
	
	ALPHA = lightning * clamp(0., 1., segment1 + segment2 + segment3) * gradient_sample.a;
}
