// NOTE: Shader automatically converted from Godot Engine 4.6.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_burley, specular_schlick_ggx, unshaded;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_disable;
uniform ivec2 albedo_texture_size;
uniform float point_size : hint_range(0.1, 128.0, 0.1);

uniform float roughness : hint_range(0.0, 1.0);
uniform sampler2D texture_metallic : hint_default_white, filter_linear_mipmap, repeat_disable;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness : hint_roughness_r, filter_linear_mipmap, repeat_disable;

uniform float specular : hint_range(0.0, 1.0, 0.01);
uniform float metallic : hint_range(0.0, 1.0, 0.01);

uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;

uniform float bowl_radius = 3.;

varying vec3 local_pos;

void vertex() {
	// Vertex Color is sRGB: Enabled
	if (!OUTPUT_IS_SRGB) {
		COLOR.rgb = mix(
				pow((COLOR.rgb + vec3(0.055)) * (1.0 / (1.0 + 0.055)), vec3(2.4)),
				COLOR.rgb * (1.0 / 12.92),
				lessThan(COLOR.rgb, vec3(0.04045)));
	}

	UV = UV * uv1_scale.xy + uv1_offset.xy;
	
	local_pos = VERTEX;
}

void fragment() {
	vec2 base_uv = UV;


	// Vertex Color Use as Albedo: Enabled
	//albedo_tex *= COLOR;

	//ALBEDO = albedo.rgb * albedo_tex.rgb;
float radius = length(local_pos.xz);
radius = clamp(radius / bowl_radius, 0.0, 1.0);

vec2 uv;
uv.x = fract(atan(local_pos.z, local_pos.x) / TAU + 0.5);
uv.y = radius;

vec4 sample = texture(texture_albedo, uv);

    ALBEDO = sample.rgb;
	//ALBEDO = vec3(local_pos.x * 0.5 + 0.5);
    //EMISSION = vec3(gradient) * 5.0;
}
