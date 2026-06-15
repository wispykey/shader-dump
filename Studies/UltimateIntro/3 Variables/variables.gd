extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Icon.material.set_shader_parameter('Color', Color.AQUA)
	
	var tween = create_tween()
	tween.set_loops()
	
	tween.tween_property($Icon.material, 'shader_parameter/Radius', 0.4, 1)
	
	tween.chain()
	
	tween.tween_property($Icon.material, 'shader_parameter/xShift', 40, 1)
	
	tween.chain()
	
	tween.tween_property($Icon.material, 'shader_parameter/xShift', 0, 1)
	
	tween.tween_property($Icon.material, 'shader_parameter/Radius', 0.2, 1)
	
