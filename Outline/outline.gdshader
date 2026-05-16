shader_type canvas_item;


uniform vec4 outline_color: source_color = vec4(1);
uniform float outline_thickness: hint_range(0.0, 1.0) = 0.5;

const float max_line_thickness = 2.;

void fragment() {
	vec4 color = COLOR;
	float outline = COLOR.a;
	
	vec2 size = TEXTURE_PIXEL_SIZE * outline_thickness * max_line_thickness;
	
	outline += texture(TEXTURE, UV + vec2(size.x, 0.)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, 0.)).a;
	outline += texture(TEXTURE, UV + vec2(0., size.y)).a;
	outline += texture(TEXTURE, UV + vec2(0., -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	
	outline = min(outline, 1.);
	COLOR = mix(color, outline_color, outline - color.a);
}

