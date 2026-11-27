extends MeshInstance3D

@export var enabled: bool = true
@export var destination_scene: PackedScene
var can_interact = false

func _ready() -> void:
	$DetectionZone.body_entered.connect(_on_body_detected)
	$DetectionZone.body_exited.connect(_on_body_exited)
	GameEvents.interact.connect(_on_interact)

func _on_body_detected(body: Node3D):
	if !enabled: return
	
	can_interact = true
	GameEvents.portal_nearby.emit()
	print("HI")

func _on_body_exited(body: Node3D):
	if !enabled: return
	
	can_interact = false
	GameEvents.portal_no_longer_nearby.emit()
	print("BYE")

func _on_interact():
	if !enabled: return
	
	get_tree().change_scene_to_packed(destination_scene)
