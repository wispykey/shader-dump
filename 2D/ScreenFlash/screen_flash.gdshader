shader_type canvas_item;

uniform float time_elapsed = 0.;
uniform float duration: hint_range(0.01, 1.0, 0.01) = 0.5;

void fragment() {
	// Since TIME is independent of spawn time, need to set uniform instead
	COLOR.a = (duration - time_elapsed) / max(duration, 0.01);
	//COLOR.a = 1.;
}
