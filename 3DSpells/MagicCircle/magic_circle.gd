extends Node3D

class_name MagicCircle

@export var base_outer_ring_rotation_speed: float = 0.5
@export var base_inner_ring_rotation_speed: float = 0.3
@export var does_inner_ring_flash_color: bool = true
@export var does_inner_ring_rotate_faster: bool = true
@export var rotation_speed_decay_time: float = 1.;

var outer_ring_rotation_speed: float = base_outer_ring_rotation_speed
var inner_ring_rotation_speed: float = base_inner_ring_rotation_speed


@export var cast_rotation_speed_increase_per_frame: float = 0.5
@export var cast_color_intensity_multiplier: float = 2.5

@export var is_omnilight_visible = false
	
func _ready() -> void:
	$OmniLight3D.visible = is_omnilight_visible

func _process(delta: float) -> void:
	$OuterRing.rotation.y = fmod($OuterRing.rotation.y + outer_ring_rotation_speed * delta, 360.)
	$InnerRing.rotation.y = fmod($InnerRing.rotation.y - inner_ring_rotation_speed * delta, 360.)


func play_cast_finish(color: Color = Color.WHITE):
	var inner_circle_material: StandardMaterial3D = $InnerRing.material_override
	var outer_circle_material: StandardMaterial3D = $OuterRing.material_override
	$OmniLight3D.light_color = color * 0.5

	var intense_color = Color(color) * cast_color_intensity_multiplier

	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(outer_circle_material, "albedo_color", intense_color, 0.2)
	if does_inner_ring_flash_color:
		tween.tween_property(inner_circle_material, "albedo_color", intense_color, 0.2)

	tween.tween_property(self, "outer_ring_rotation_speed", base_outer_ring_rotation_speed + cast_rotation_speed_increase_per_frame, 0.1)
	if does_inner_ring_rotate_faster:
		tween.tween_property(self, "inner_ring_rotation_speed", base_inner_ring_rotation_speed + cast_rotation_speed_increase_per_frame, 0.1)
	
	tween.chain()
	
	tween.tween_property(outer_circle_material, "albedo_color", Color.WHITE, 0.5)
	if does_inner_ring_flash_color:
		tween.tween_property(inner_circle_material, "albedo_color", Color.WHITE, 0.5)
	
	tween.tween_property(self, "outer_ring_rotation_speed", base_outer_ring_rotation_speed, rotation_speed_decay_time)
	if does_inner_ring_rotate_faster:
		tween.tween_property(self, "inner_ring_rotation_speed", base_inner_ring_rotation_speed, rotation_speed_decay_time)
	
	tween.tween_property($OmniLight3D, "light_color", Color.WHITE, 0.5)
	
	tween.play()
	

	
