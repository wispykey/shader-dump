shader_type spatial;
render_mode cull_disabled;

uniform vec3 color: source_color;
uniform vec3 color2: source_color;

uniform sampler2D noise;
uniform float noise_scale = 20.0;

varying vec3 worldPos;

void vertex() {
	// Called for every vertex the material is visible on.
	worldPos = (MODEL_MATRIX * vec4(VERTEX, 1.)). xyz;
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 noise_level = texture(noise, worldPos.xz / noise_scale).rgb;
	ALBEDO = mix(color, color2, UV.y) * mix(color, color2, noise_level.r);
	
	if (!FRONT_FACING) {
		NORMAL = -NORMAL;
	}
	
}
