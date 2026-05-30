extends Node3D

@export var one_shot_particles: PackedScene

func _ready():
	var mat: StandardMaterial3D = $"LargeShard/LargeShard-rigid".material_override
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)


func _on_animation_finished(anim_name: String):
	queue_free()


func spawn_particles():
	var particles_inst = one_shot_particles.instantiate()
	particles_inst.position.y += 2;
	add_child(particles_inst)
