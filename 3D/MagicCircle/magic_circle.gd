extends Node3D

@export var outer_ring_rotation_speed: float = 0.5
@export var inner_ring_rotation_speed: = 0.3


func _process(delta: float) -> void:
	$OuterRing.rotation.y = fmod($OuterRing.rotation.y + outer_ring_rotation_speed * delta, 360.)
	$InnerRing.rotation.y = fmod($InnerRing.rotation.y - inner_ring_rotation_speed * delta, 360.)
