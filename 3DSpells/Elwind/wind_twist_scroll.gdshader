shader_type spatial;

uniform sampler2D color: source_color;
uniform sampler2D albedo_tex;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 base_uv = vec2(UV.x, UV.y - 1.);
	
	base_uv += TIME / 2.;
	// Called for every pixel the material is visible on.
	vec4 albedo_sample = texture(albedo_tex, base_uv);
	ALPHA = albedo_sample.a;
	ALBEDO = texture(color, vec2(albedo_sample.r)).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
