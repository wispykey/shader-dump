shader_type canvas_item;

varying vec2 vertex_varying;

void vertex() {
	// Called for every vertex the material is visible on.
	//VERTEX.x += sin(VERTEX.y * 10.) * 40.;
	
	vertex_varying = VERTEX;
}

void fragment() {
	//COLOR.rgb = vec3(vertex_varying.x /64., vertex_varying.y / 64., 0);
	//COLOR.a = 1.;
	
	//COLOR.rgb = vec3(VERTEX.x * SCREEN_PIXEL_SIZE.x, VERTEX.y * SCREEN_PIXEL_SIZE.y, 0);
	COLOR.rgb = vec3(1.);
	
}