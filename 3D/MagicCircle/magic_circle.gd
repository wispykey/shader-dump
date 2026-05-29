extends Node3D

class_name MagicCircle

@export var base_outer_ring_rotation_speed: float = 0.5
@export var base_inner_ring_rotation_speed: float = 0.3

var outer_ring_rotation_speed: float = base_outer_ring_rotation_speed
var inner_ring_rotation_speed: float = base_inner_ring_rotation_speed


@export var cast_rotation_speed_increase_per_frame: float = 0.5
@export var cast_color_intensity_multiplier: float = 5.

func _process(delta: float) -> void:
	$OuterRing.rotation.y = fmod($OuterRing.rotation.y + outer_ring_rotation_speed * delta, 360.)
	$InnerRing.rotation.y = fmod($InnerRing.rotation.y - inner_ring_rotation_speed * delta, 360.)


func play_cast_finish(color: Color = Color.WHITE):
	var inner_circle_material: StandardMaterial3D = $InnerRing.material_override
	var outer_circle_material: StandardMaterial3D = $OuterRing.material_override
	
	inner_circle_material.albedo_color = color
	
	var tween = create_tween().set_parallel(true)
	
	var intense_color = Color(color) * cast_color_intensity_multiplier

	tween.tween_property(inner_circle_material, "albedo_color", intense_color, 0.2)
	tween.tween_property(outer_circle_material, "albedo_color", intense_color, 0.2)

	tween.tween_property(self, "outer_ring_rotation_speed", base_outer_ring_rotation_speed + cast_rotation_speed_increase_per_frame, 0.1)
	tween.tween_property(self, "inner_ring_rotation_speed", base_inner_ring_rotation_speed + cast_rotation_speed_increase_per_frame, 0.1)
	
	tween.chain()

	tween.tween_property(inner_circle_material, "albedo_color", Color.WHITE, 0.5)
	tween.tween_property(outer_circle_material, "albedo_color", Color.WHITE, 0.5)
	
	tween.tween_property(self, "outer_ring_rotation_speed", base_outer_ring_rotation_speed, 1.5)
	tween.tween_property(self, "inner_ring_rotation_speed", base_inner_ring_rotation_speed, 1.5)
	
	tween.play()
	

	
