extends Node3D

func _ready() -> void:
	GameEvents.portal_nearby.connect(_on_portal_nearby)
	GameEvents.portal_no_longer_nearby.connect(_on_portal_no_longer_nearby)

func _on_portal_nearby():
	$Interact.visible = true

func _on_portal_no_longer_nearby():
	$Interact.visible = false
