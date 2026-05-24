shader_type canvas_item;

uniform float x_offset = 50.;
uniform float scale_factor = 1.;

uniform float x_rotation: hint_range(0., 1.);
uniform float y_rotation: hint_range(0., 1.);
uniform float z_rotation: hint_range(0., 1.);

uniform vec2 pivot;

void vertex() {
	// Called for every vertex the material is visible on.
	mat3 scale_matrix = mat3(
		vec3(scale_factor,0,0), // keep original x contribution
		vec3(0,scale_factor,0), // keep original y contribution
		vec3(0,0,scale_factor));
		
	mat3 translation_matrix = mat3(
		vec3(1,0,0),
		vec3(0,1,0),
		vec3(x_offset, 0, 1)
	);
	
	mat3 x_rotation_matrix = mat3(
		vec3(1, 0, 0),
		vec3(0, cos(x_rotation * TAU), sin(x_rotation * TAU)),
		vec3(0, -sin(x_rotation* TAU), cos(x_rotation* TAU))
	);
	
	mat3 y_rotation_matrix = mat3(
		vec3(cos(y_rotation* TAU), 0, -sin(y_rotation* TAU)),
		vec3(0, 1, 0),
		vec3(sin(y_rotation* TAU), 0, cos(y_rotation* TAU))
	);
	
	mat3 z_rotation_matrix = mat3(
		vec3(cos(z_rotation* TAU), -sin(z_rotation* TAU), 0),
		vec3(sin(z_rotation* TAU), cos(z_rotation* TAU), 0),
		vec3(0, 0, 1)
	);
	
	mat3 matrix =  x_rotation_matrix * y_rotation_matrix * z_rotation_matrix;
	vec3 result = matrix * vec3(VERTEX, 1.);
	VERTEX = result.xy;
	
	// Use translate, rotate, translate to rotate around a pivot point
	vec3 v = vec3(VERTEX, 1.) - vec3(pivot, 1.);
	v = matrix * v;
	v += vec3(pivot, 1.);
	
	VERTEX = v.xy;
	
	
}

void fragment() {
	// Called for every pixel the material is visible on.
}


