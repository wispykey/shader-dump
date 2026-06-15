extends Node3D


var time_since_spawn = 0.;

func _process(delta: float) -> void:
	var shader: ShaderMaterial = $MeshInstance3D.material_override
	time_since_spawn += delta;
	shader.set_shader_parameter("time_since_spawn", time_since_spawn)
