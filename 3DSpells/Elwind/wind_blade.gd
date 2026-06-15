extends Node3D
class_name WindBlade

func set_alpha(a: float):
	var wind_material: StandardMaterial3D = $Plane.material_override
	wind_material.albedo_color.a = a
	
	$Hitbox.set_deferred("monitorable", a >= 0.1)
