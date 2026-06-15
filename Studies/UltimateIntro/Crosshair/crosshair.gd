extends Node2D

func _ready() -> void:
	var sprite = $Sprite2D
	sprite.material.set_shader_parameter('ring_width', 0.)
	sprite.material.set_shader_parameter('line_width', 0.)
	
	var tween = create_tween()
	
	tween.tween_property(sprite.material, 'shader_parameter/ring_width', 0.8, 0.25)
	tween.parallel().tween_property(sprite.material, 'shader_parameter/line_width', 0.5, 0.25)
	
	##tween.tween_property(self, 'scale', 1.5, 0.4)
	#tween.tween_property(self, 'rotation', PI/4, 0.25)
	#tween.parallel().tween_property(sprite.material, 'shader_parameter/line_length', 0.6, 0.25)
	#tween.parallel().tween_property(sprite.material, 'shader_parameter/center_size', 0.65, 0.25)
	
	tween.tween_property(self, 'rotation', 3*PI/4, 0.3)
	tween.parallel().tween_property(sprite.material, 'shader_parameter/line_length', 0.5, 0.25)
	tween.parallel().tween_property(sprite.material, 'shader_parameter/center_size', 0.5, 0.3)
	
