extends CharacterBody3D
@export var acceleration: float = 100.
@export var max_speed: float = 10.
@export var camera: Node3D
@export var extra_rotation: float = 45.

@export var skill: PackedScene
@onready var anim_tree := $AnimationTree
@onready var anim_player := $AnimationPlayer

@export var cast_distance = 15.


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
	

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("hotbar_1_skill_1"):
		curr_anim_enum = AnimationNames.RUN_FORWARDS_CASTING
		
		var skill_inst = skill.instantiate()
		var spring_rotation = $SpringArmPivot.rotation.y + PI/2
		var distance = Vector3(cos(spring_rotation), 0, -sin(spring_rotation)) * cast_distance
		owner.add_child(skill_inst) if owner else add_child(skill_inst)
		skill_inst.global_position = global_position + distance
		$MagicCircle.play_cast_finish(Color(1.0, 0.884, 0.42, 1.0))
		
		# TODO: When exactly should the animation revert anyways?
		# Also, this doesn't account for other strafe directions
		skill_inst.tree_exited.connect(set_next_anim_enum.bind(AnimationNames.RUN_FORWARDS))
	
	var input_dir := Input.get_vector(&"move_right", &"move_left", &"move_forward", &"move_backward")
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
