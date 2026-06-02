extends Node3D

@export var broken_model: PackedScene

@onready var pot_mesh = $PotMesh

@export var despawn_time: float = 5.


func _ready() -> void:
	pot_mesh.broken.connect(_on_pot_mesh_broken)


func _on_pot_mesh_broken():
	shatter()


func shatter():

	var broken_model_inst: Node3D = broken_model.instantiate()
	broken_model_inst.position = pot_mesh.position
	
	add_child(broken_model_inst)

	pot_mesh.queue_free()

	SFX.play_pot_shatter()

	await get_tree().create_timer(despawn_time).timeout;
	queue_free()
