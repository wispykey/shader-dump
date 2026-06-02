extends Node3D

@export var screen_flash_scene: PackedScene

func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	$MediumBolts.rotation += Vector3(
		0., randi_range(0, 1) * PI, 0.
	)
	
func _on_animation_finished(anim_name: String):
	queue_free()

func call_screen_flash():
	#add_child(screen_flash_scene.instantiate())
	pass
	
	
