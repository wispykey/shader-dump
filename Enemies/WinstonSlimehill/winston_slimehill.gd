extends Node3D

var time_elapsed = 0.
@export var jump_distance = 1.

func _process(delta: float) -> void:
		
	time_elapsed += delta
	if time_elapsed > 3.:
		time_elapsed = 0.
		$AnimationTree["parameters/Jump/request"] = 1
		
		var tween = create_tween()
		
		tween.tween_property(self, "position", position + Vector3(0, 0, jump_distance), 0.5)
