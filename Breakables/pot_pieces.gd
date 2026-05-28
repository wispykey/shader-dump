extends Node3D


@export var INTENSITY: float = 3.;

func _ready() -> void:
	var pieces = self.get_children()
	for piece in pieces:
		var random_intensity_offset: float = randf_range(0., 3.)
		piece.apply_impulse(piece.position * (INTENSITY + random_intensity_offset), self.global_position)

	await get_tree().create_timer(5).timeout;
	queue_free();
