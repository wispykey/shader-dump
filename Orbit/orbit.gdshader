shader_type canvas_item;

uniform float planet_size: hint_range(0.1, 1.0) = 0.5;
uniform float moon_size: hint_range(0.1, 1.0) = 0.5;
uniform float moon_distance: hint_range(0.1, 1.0) = 0.5;

uniform vec3 planet_color: source_color;
uniform vec3 moon_color: source_color;
uniform vec3 asteroid_color: source_color;

const float max_moon_distance = 1.;

void fragment() {
	// Center uvec2
	vec2 centered_uv = (UV - 0.5) * 2.;
	
	// Create a planet in center
	float planet = step(distance(centered_uv, vec2(0)), planet_size * 0.5);
	COLOR.rgb = mix(COLOR.rgb, planet_color, planet);
	
	// Create a moon some distance away from the planet
	vec2 moon_position =  normalize(vec2(cos(TIME), sin(TIME))) * moon_distance * max_moon_distance;
	float moon = step(distance(centered_uv, moon_position), moon_size * 0.3);
	COLOR.rgb = mix(COLOR.rgb, moon_color, moon);
	
	// Center asteroid around the moon
	vec2 asteroid_position = normalize(vec2(cos(TIME), -sin(TIME))) * (moon_size * 0.5);
	asteroid_position += moon_position;
	float asteroid = step(distance(centered_uv, asteroid_position), moon_size * 0.1);
	COLOR.rgb = mix(COLOR.rgb, asteroid_color, asteroid);
	
	COLOR.a = planet + moon + asteroid;
}