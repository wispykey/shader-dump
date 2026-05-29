extends Node3D

func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	
	
func _on_animation_finished(_anim_name: String):
	queue_free()
