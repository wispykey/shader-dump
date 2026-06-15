shader_type spatial;

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    float a = fract(sin(dot(i, vec2(127.1, 311.7))) * 43758.5453);
    float b = fract(sin(dot(i + vec2(1.0, 0.0), vec2(127.1, 311.7))) * 43758.5453);
    float c = fract(sin(dot(i + vec2(0.0, 1.0), vec2(127.1, 311.7))) * 43758.5453);
    float d = fract(sin(dot(i + vec2(1.0, 1.0), vec2(127.1, 311.7))) * 43758.5453);

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}


void vertex() {
	// Called for every vertex the material is visible on.
	float height = sin(VERTEX.x + TIME);
	height += sin(VERTEX.z - TIME);
	
	VERTEX.y = noise((VERTEX.xz + TIME) * 1.2);
}

void fragment() {
	// Called for every pixel the material is visible on.
	float h = noise(UV * 10.);
	ALBEDO = vec3(h);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
