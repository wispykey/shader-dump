extends Node3D


@export var pot: PackedScene
@export var pot_scale: float = 0.8
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

	$PotsAutoSpawner.wait_time = pots_respawn_interval
	$PotsAutoSpawner.timeout.connect(_on_pots_auto_spawner_timeout)
	$PotsAutoSpawner.start()
	
	init_pots()




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

			


func _on_pots_auto_spawner_timeout():
	respawn_pots()
	$PotsAutoSpawner.start()
	
	
