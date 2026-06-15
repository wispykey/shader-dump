extends AnimatedSprite2D

func _process(delta: float) -> void:
    var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    position += direction * 100 * delta;