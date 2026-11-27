extends CharacterBody3D
@export var acceleration: float = 100.
@export var max_speed: float = 10.
@export var camera: Node3D
@export var extra_rotation: float = 45.

@onready var anim_tree := $AnimationTree
@onready var anim_player := $AnimationPlayer
@onready var magic_circle: MagicCircle = $MagicCircle

@export var skill_distance: float = 8.
@export var skill_loadout: Array[PackedScene] = []

enum AnimationNames {
	IDLE = 0,
	RUN_FORWARDS = 1,
	RUN_FORWARDS_CASTING = 2,
}

var anim_vals: Dictionary = {
	AnimationNames.IDLE: 1.,
	AnimationNames.RUN_FORWARDS: 0.,
	AnimationNames.RUN_FORWARDS_CASTING: 0.,
}

var blend_speed: float = 10.
var curr_anim_enum = AnimationNames.IDLE



func handle_animations(delta: float):
	for anim in anim_vals.keys():
		if anim == curr_anim_enum:
			anim_vals[anim] = lerpf(anim_vals[anim], 1., blend_speed * delta)
		else:
			anim_vals[anim] = lerpf(anim_vals[anim], 0., blend_speed * delta)

	update_animation_tree()
	
	
func update_animation_tree():
	# This is annoying, relies on coupled animation name strings :(
	anim_tree["parameters/RunForwards/blend_amount"] = anim_vals[AnimationNames.RUN_FORWARDS]
	anim_tree["parameters/RunForwardsCasting/blend_amount"] = anim_vals[AnimationNames.RUN_FORWARDS_CASTING]
	#anim_tree["parameters/Idle/blend_amount"] = anim_vals[AnimationNames.IDLE]

func _ready() -> void:
	$HackyAnimTimer.timeout.connect(set_next_anim_enum.bind(AnimationNames.RUN_FORWARDS))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("hotbar_1_skill_1"):
		use_skill(0)
	elif Input.is_action_just_pressed("hotbar_1_skill_2"):
		use_skill(1)
	elif Input.is_action_just_pressed("hotbar_1_skill_3"):
		use_skill(2)
	elif Input.is_action_just_pressed("hotbar_1_skill_4"):
		use_skill(3)
	elif Input.is_action_just_pressed("hotbar_1_skill_5"):
		use_skill(4)
	
	if Input.is_action_just_pressed("interact"):
		GameEvents.interact.emit()
		



func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")
	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	
	direction = direction.rotated(Vector3.UP, camera.global_rotation.y)
	
	if direction: 
		direction *= max_speed
		velocity.x = move_toward(velocity.x, direction.x, delta * acceleration)
		velocity.z = move_toward(velocity.z, direction.z, delta * acceleration)
		if curr_anim_enum != AnimationNames.RUN_FORWARDS_CASTING:
			curr_anim_enum = AnimationNames.RUN_FORWARDS
		
	else:
		velocity.x = move_toward(velocity.x, 0, delta * acceleration)
		velocity.z = move_toward(velocity.z, 0, delta * acceleration)
		if curr_anim_enum != AnimationNames.RUN_FORWARDS_CASTING:
			curr_anim_enum = AnimationNames.IDLE
		velocity = Vector3.ZERO
	
	move_and_slide()
	handle_animations(delta)
	
	$GeneralSkeleton.rotation.y = $SpringArmPivot.rotation.y + PI

	
func set_next_anim_enum(anim_enum: AnimationNames):
	curr_anim_enum = anim_enum

func handle_left_footstep():
	# Blending causes 'running' to be active even during 'idle'
	# So we need to manually mute footsteps, currently
	if anim_vals[AnimationNames.IDLE] > 0.5:
		return
	SFX.play_left_footstep()
	
func handle_right_footstep():
	if anim_vals[AnimationNames.IDLE] > 0.5:
		return
	SFX.play_right_footstep()
	
func use_skill(skill_index: int):
	if skill_index >= len(skill_loadout):
		print("Skill index out of range")
		return

	# Eventually make this a lookup with other per-skill info
	match skill_index:
		0:
			magic_circle.play_cast_finish(Color(1.0, 0.884, 0.42, 1.0))
		1:
			magic_circle.play_cast_finish(Color.POWDER_BLUE)
		2: 
			magic_circle.play_cast_finish(Color.PALE_GREEN)		
			# Should rotation be random?
		3:
			magic_circle.play_cast_finish(Color.BURLYWOOD)
		4:
			magic_circle.play_cast_finish(Color.SKY_BLUE)
		_:
			magic_circle.play_cast_finish()
			
	
	var skill_inst = skill_loadout[skill_index].instantiate()
	var spring_rotation = $SpringArmPivot.rotation.y + PI/2
	var distance = Vector3(cos(spring_rotation), 0, -sin(spring_rotation)) * skill_distance
	owner.add_child(skill_inst) if owner else add_child(skill_inst)
	skill_inst.global_position = global_position + distance
	
	# Always faces player at spawn time
	skill_inst.rotation.y = $SpringArmPivot.rotation.y

	curr_anim_enum = AnimationNames.RUN_FORWARDS_CASTING
	$HackyAnimTimer.start()
