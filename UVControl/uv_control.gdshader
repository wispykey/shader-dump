shader_type canvas_item;
//uniform float x: hint_range(0.0, 1.0);

uniform float pixellation_intensity: hint_range(0.0, 1.0);
const float max_resolution = 128.;

void fragment() {
	//vec2 scaled_uv = UV * 2. - vec2(x, 0.);
	//vec2 scaled_uv = UV * pixellation_intensity * 30.;
	//vec4 scaled_texture = texture(TEXTURE, scaled_uv);
	//vec2 mask = step(vec2(0), scaled_uv) * step(scaled_uv, vec2(1));
	//scaled_texture.a *= mask.x * mask.y;
	//COLOR = scaled_texture;
	
	float resolution = floor((1. - pixellation_intensity) * max_resolution);
	vec2 grid = vec2(resolution);
	vec2 pixel_uv = floor(UV * grid + vec2(0.5)) / grid;
	COLOR.rgb = vec3(pixel_uv, 0);
	COLOR.rgb = texture(TEXTURE, pixel_uv).rgb;
	
	
	
	//vec2 uv = (UV - 0.5) * 2.;
	//COLOR.a = distance(abs(uv.x), 0.5);
	//COLOR.rgb = vec3(uv, 0.);
	
	//float intensity = floor(pixellation_intensity * 30.);
	//vec2 grid = vec2(intensity);
	//
	//vec2 pixel_uv = floor(scaled_uv * grid) / grid;
	//COLOR.rgb = vec3(pixel_uv, 0.);
	//COLOR.rgb = texture(TEXTURE, pixel_uv).rgb;
	//
}
