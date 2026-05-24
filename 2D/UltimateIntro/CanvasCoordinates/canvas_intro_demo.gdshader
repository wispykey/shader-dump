shader_type canvas_item;

varying vec2 screen_pos;

uniform sampler2D screen_texture: hint_screen_texture;

void vertex() {
	// Called for every vertex the material is visible on.
	
	screen_pos = (CANVAS_MATRIX * MODEL_MATRIX * vec4(VERTEX, 0., 1.)).xy;
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	//COLOR.rgb = vec3(screen_pos * SCREEN_PIXEL_SIZE, 0);
	
	COLOR.rgb = 1. -texture(screen_texture, SCREEN_UV).rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
