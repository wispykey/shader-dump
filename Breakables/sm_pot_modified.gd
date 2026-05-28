extends Node3D

signal broken

func _ready() -> void:
    $Hitbox.area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D):
    print("area detected", area)

    broken.emit()