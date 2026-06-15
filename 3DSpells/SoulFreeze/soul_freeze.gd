extends Node3D

@export var tiny_shards: PackedScene
@export var cold_pulse_wave: PackedScene

func _ready():
	var mat: StandardMaterial3D = $"LargeShard/LargeShard-rigid".material_override
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)


func _on_animation_finished(anim_name: String):
	queue_free()

func spawn_cold_pulse_wave():
	var particles_inst = cold_pulse_wave.instantiate()
	add_child(particles_inst)

func spawn_tiny_shards():
	var particles_inst = tiny_shards.instantiate()
	particles_inst.position.y += 2;
	add_child(particles_inst)
