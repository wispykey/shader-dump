extends CharacterBody3D
@export var acceleration: float = 100.
@export var max_speed: float = 10.
@export var camera: Node3D
@export var extra_rotation: float = 45.

@export var skill: PackedScene
@onready var anim_tree := $AnimationTree
@onready var anim_player := $AnimationPlayer


enum AnimationNames {
	RUN_FORWARDS = 0,
	RUN_FORWARDS_CASTING = 1
}

var anim_vals: Dictionary = {
	AnimationNames.RUN_FORWARDS: 1.,
	AnimationNames.RUN_FORWARDS_CASTING: 0.,
}

var blend_speed: float = 25.
var curr_anim_enum = AnimationNames.RUN_FORWARDS

func _process(delta: float) -> void:
	$MagicCircle.visible = anim_vals[AnimationNames.RUN_FORWARDS_CASTING] > 0.05
	$MagicCircle.play_cast_finish(Color(1.0, 0.884, 0.42, 1.0))
		

func handle_animations(delta: float):
	match curr_anim_enum:
		AnimationNames.RUN_FORWARDS:
			anim_vals[AnimationNames.RUN_FORWARDS] = lerpf(anim_vals[AnimationNames.RUN_FORWARDS], 1., blend_speed * delta)
			anim_vals[AnimationNames.RUN_FORWARDS_CASTING] = lerpf(anim_vals[AnimationNames.RUN_FORWARDS_CASTING], 0., blend_speed * delta)
		AnimationNames.RUN_FORWARDS_CASTING:
			anim_vals[AnimationNames.RUN_FORWARDS] = lerpf(anim_vals[AnimationNames.RUN_FORWARDS], 0., blend_speed * delta)
			anim_vals[AnimationNames.RUN_FORWARDS_CASTING] = lerpf(anim_vals[AnimationNames.RUN_FORWARDS_CASTING], 1., blend_speed * delta)
				
	update_animation_tree()
	
	
func update_animation_tree():
	anim_tree["parameters/RunForwardCasting/blend_amount"] = anim_vals[AnimationNames.RUN_FORWARDS_CASTING]

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("hotbar_1_skill_1"):
		curr_anim_enum = AnimationNames.RUN_FORWARDS_CASTING
		
		var skill_inst = skill.instantiate()
		var spring_rotation = $SpringArmPivot.rotation.y + PI/2
		var distance = Vector3(cos(spring_rotation), 0, -sin(spring_rotation)) * 10.
		skill_inst.position = distance
		add_child(skill_inst)
		
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
		
	else:
		velocity.x = move_toward(velocity.x, 0, delta * acceleration)
		velocity.z = move_toward(velocity.z, 0, delta * acceleration)
		
		velocity = Vector3.ZERO
	
	move_and_slide()
	handle_animations(delta)
	
	$GeneralSkeleton.rotation.y = $SpringArmPivot.rotation.y + PI

	
func set_next_anim_enum(anim_enum: AnimationNames):
	curr_anim_enum = anim_enum
