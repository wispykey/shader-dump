extends Node3D


@export var skill_distance: float = 8.
@export var skill_loadout: Array[PackedScene] = []
@export var pot: PackedScene
@export var pot_scale: float = 0.8


@export var auto_spawning_skills: bool = false
@export var periodic_spawn_skill_index = 0
@export var subsequent_skill_spawn_time_interval = 4.
@export var pots_respawn_interval = 5.

# Pot spawning info
const spacing: float = 2.
const num_pots_row: int = 10
const num_pots_col: int = 10
const num_pots: int = num_pots_col * num_pots_row

@onready var player: ProtoController = $ProtoController
@onready var magic_circle: MagicCircle = $ProtoController/MagicCircle

var spawned_pots: Array[Node3D] = []

func _ready() -> void:
	$ProtoController.skill_used.connect(_on_skill_used)
	
	$SkillAutoSpawner.timeout.connect(_on_skill_auto_spawner_timeout)
	$SkillAutoSpawner.start()
	
	$PotsAutoSpawner.wait_time = pots_respawn_interval
	$PotsAutoSpawner.timeout.connect(_on_pots_auto_spawner_timeout)
	$PotsAutoSpawner.start()
	
	init_pots()


func _on_skill_used(skill_index: int):
	if skill_index >= len(skill_loadout):
		print("Skill index out of range")
		return
	

	var skill_inst: Node3D = skill_loadout[skill_index].instantiate()

	var angle = -1 * player.look_rotation.y
	var player_facing_dir = Vector3(sin(angle), 0, -cos(angle))

	var offset = player_facing_dir * skill_distance
	var spawn_position = Vector3(player.position.x, 0., player.position.z) + offset

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
		3:
			magic_circle.play_cast_finish(Color(1.0, 0.884, 0.42, 1.0))
		_:
			magic_circle.play_cast_finish()
			
			
	add_child(skill_inst)


func init_pots():
	var offset = $Pots.position + Vector3(
		-0.5 * (num_pots_row - 1) * spacing,
		0,
		-0.5 * (num_pots_col - 1) * spacing
	)
		
	for i in range(num_pots):
		var x = i / num_pots_row
		var z = i % num_pots_row 
		
		var pot_inst: Node3D = pot.instantiate()
		pot_inst.position = Vector3(
			offset.x + x * spacing,
			0, 
			offset.z + z * spacing,
		)
		
		# Vary rotation to add more entropy to impact
		pot_inst.rotation.y = randf_range(0., TAU)
		pot_inst.scale *= pot_scale
		$Pots.add_child(pot_inst)
		
		spawned_pots.append(pot_inst)
	
	
func respawn_pots():
	var offset = $Pots.position + 0.5 * Vector3(
		-(num_pots_row + spacing), 
		0, 
		num_pots_col + spacing)
	
	for i in range(num_pots):
		var x = i / num_pots_row
		var z = i % num_pots_row
		
		if spawned_pots[i]:
			continue
		
		var pot_inst: Node3D = pot.instantiate()
		pot_inst.position = Vector3(
			offset.x + x * spacing,
			0, 
			offset.z - z * spacing,
		)
		
		# Vary rotation to add more entropy to impact
		pot_inst.rotation.y = randf_range(0., TAU)
		pot_inst.scale *= pot_scale
		add_child(pot_inst)
		
		spawned_pots[i] = pot_inst

			
func _on_skill_auto_spawner_timeout():
	if auto_spawning_skills:
		_on_skill_used(periodic_spawn_skill_index)
	# Set here because I am impatient and want the first spawn to happen faster
	# (first spawn is set on Timer node, then subsequent intervals are different)
	$SkillAutoSpawner.wait_time = subsequent_skill_spawn_time_interval	
	$SkillAutoSpawner.start()
	

func _on_pots_auto_spawner_timeout():
	respawn_pots()
	$PotsAutoSpawner.start()
	
	
