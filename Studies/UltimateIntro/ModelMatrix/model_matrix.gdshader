shader_type canvas_item;

varying vec2 world_pos;

uniform vec2 circle_pos = vec2(100., 150.);
uniform float circle_radius = 200.;
uniform float amount: hint_range(0., 1.) = 0.5;

uniform sampler2D space_texture: repeat_enable;

void vertex() {
	// Called for every vertex the material is visible on.
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	
	//COLOR.a = step(circle_radius, distance(world_pos, circle_pos));
	
	vec4 space_color = texture(space_texture, world_pos * TEXTURE_PIXEL_SIZE * 0.1);
	COLOR.rgb = mix(COLOR.rgb, space_color.rgb, amount);
	
	//COLOR = space_color;
	
	
	//COLOR.rgb = vec3(world_pos, 0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
