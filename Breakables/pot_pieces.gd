extends Node3D


@export var INTENSITY: float = 3.;

func _ready() -> void:
	var pieces = self.get_children()
	for piece in pieces:
		piece.apply_impulse(piece.position * INTENSITY, self.global_position)

	await get_tree().create_timer(5).timeout;
	queue_free();
