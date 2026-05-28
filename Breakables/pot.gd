extends Node3D

@export var broken_model: PackedScene

@onready var pot_mesh = $Pot


func _ready() -> void:
	pot_mesh.broken.connect(_on_pot_mesh_broken)

	$AudioStreamPlayer3D.finished.connect(queue_free)


func _on_pot_mesh_broken():
	shatter()


func shatter():
	var broken_model_inst: Node3D = broken_model.instantiate()

	add_child(broken_model_inst)
	broken_model_inst.transform = self.transform

	$AudioStreamPlayer3D.play()
