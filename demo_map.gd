extends Node3D


@export var skill_loadout: Array[PackedScene] = []
@export var pot: PackedScene

@onready var player: ProtoController = $ProtoController


func _ready() -> void:
	$ProtoController.skill_used.connect(_on_skill_used)
	spawn_pots()

func _on_skill_used(skill_index: int):
	if skill_index >= len(skill_loadout):
		print("Skill index out of range")
		return
	
	var skill_inst = skill_loadout[skill_index].instantiate()

	var angle = -1 * player.look_rotation.y
	print("Player angle:", angle)
	var player_facing_dir = Vector3(sin(angle), 0, -cos(angle))

	
	var skill_distance = 10.

	var offset = player_facing_dir * skill_distance
	var spawn_position = player.position + offset

	# Could look this up by skill instead
	# var skill_position = player.position + Vector3(-player_facing_dir.x, 0, player_facing_dir.y).normalized() * skill_distance


	skill_inst.position = spawn_position

	add_child(skill_inst)


func spawn_pots():
	const spacing = 2
	for x in range(5):
		for z in range(5):
			var pot_inst: Node3D = pot.instantiate()
			pot_inst.position = Vector3(x + 1, 0, z + 1) * spacing
			pot_inst.rotation.y = randf_range(0., TAU)
			add_child(pot_inst)
			var pot_inst2 = pot.instantiate()
			pot_inst2.position = Vector3(-x - 1, 0, z + 1) * spacing
			pot_inst2.rotation.y = randf_range(0., TAU)
			add_child(pot_inst2)
			
