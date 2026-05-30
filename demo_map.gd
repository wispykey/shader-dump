extends Node3D


@export var skill_distance: float = 8.
@export var skill_loadout: Array[PackedScene] = []
@export var pot: PackedScene

@onready var player: ProtoController = $ProtoController
@onready var magic_circle: MagicCircle = $ProtoController/MagicCircle

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_spawn_pots"):
		spawn_pots()

func _ready() -> void:
	$ProtoController.skill_used.connect(_on_skill_used)
	spawn_pots()

func _on_skill_used(skill_index: int):
	if skill_index >= len(skill_loadout):
		print("Skill index out of range")
		return
	

	var skill_inst: Node3D = skill_loadout[skill_index].instantiate()

	var angle = -1 * player.look_rotation.y
	var player_facing_dir = Vector3(sin(angle), 0, -cos(angle))



	var offset = player_facing_dir * skill_distance
	var spawn_position = player.position + offset

	skill_inst.position = spawn_position
	skill_inst.rotation.y = player.look_rotation.y

	
	# Eventually make this a lookup with other per-skill info
	match skill_index:
		0:
			magic_circle.play_cast_finish(Color.SKY_BLUE)
		1:
			magic_circle.play_cast_finish(Color.PALE_GREEN)
		2: 
			magic_circle.play_cast_finish(Color.POWDER_BLUE)
			# Should rotation be random?
		_:
			magic_circle.play_cast_finish()
			
			
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
			
