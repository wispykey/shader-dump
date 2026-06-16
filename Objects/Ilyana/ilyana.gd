extends Node3D
class_name Ilyana


func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_on_cast_animation_finished)

func play_cast_animation():
	$AnimationPlayer.play("arm_raise_cast/mixamo_com")
	
func _on_cast_animation_finished(anim_name: String):
	$AnimationPlayer.play("mixamo_com")
