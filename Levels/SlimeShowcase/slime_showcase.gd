extends Node3D

var time_elapsed: float = 0.

func _process(delta: float) -> void:
	$DirectionalLight3D.rotation.y += delta
	
	time_elapsed += delta
	if time_elapsed > 3.:
		time_elapsed = 0.
		$"slime v3/AnimationTree"["parameters/Jump/request"]
	
	
