shader_type canvas_item;



void vertex() {
	float z_rotation = fract(TIME / 200.);
	
	mat3 z_rotation_matrix = mat3(
		vec3(cos(z_rotation* TAU), -sin(z_rotation* TAU), 0),
		vec3(sin(z_rotation* TAU), cos(z_rotation* TAU), 0),
		vec3(0, 0, 1)
	);
	
	VERTEX = (z_rotation_matrix * vec3(VERTEX, 0.)).xy;  

	
	VERTEX += vec2(64);
	
	
	
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	//COLOR.rgb = vec3(0., 1., 0.);
	
	
}

