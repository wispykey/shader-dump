extends MeshInstance3D

@export var enabled: bool = true

func _ready() -> void:
	$DetectionZone.body_entered.connect(_on_body_detected)
	$DetectionZone.body_exited.connect(_on_body_exited)

func _on_body_detected(body: Node3D):
	print("HI")

func _on_body_exited(body: Node3D):
	print("BYE")
