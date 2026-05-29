extends Node3D

signal broken

@onready var hitbox: Area3D = $Hitbox

func _ready() -> void:
	hitbox.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D):
	hitbox.set_deferred("monitoring", false)
	broken.emit()
