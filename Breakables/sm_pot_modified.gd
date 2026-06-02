extends Node3D

signal broken

@onready var hitbox: Area3D = $Hitbox

func _ready() -> void:
	hitbox.area_entered.connect(_on_area_entered)
	hitbox.body_entered.connect(_on_body_entered)


func _on_area_entered(area: Area3D):
	hitbox.set_deferred("monitoring", false)
	broken.emit()

func _on_body_entered(body: Node3D):
	hitbox.set_deferred("monitoring", false)
	broken.emit()
