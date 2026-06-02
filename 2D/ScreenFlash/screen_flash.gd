extends ColorRect


var time_since_spawn = 0.

func _process(delta: float) -> void:
	time_since_spawn += delta;
	material.set_shader_parameter("time_elapsed", time_since_spawn)
	print(time_since_spawn)
	
