extends CharacterBody3D
@export var acceleration: float = 100.
@export var max_speed: float = 100.
@export var camera: Node3D
@export var extra_rotation: float = 45.

@export var skill: PackedScene

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hotbar_1_skill_1"):
		play_cast_animation()
		var skill_inst = skill.instantiate()
		var spring_rotation = $SpringArmPivot.rotation.y + PI/2
		print($SpringArmPivot.rotation.y)
		print(spring_rotation)
		var asdf = Vector3(cos(spring_rotation), 0, -sin(spring_rotation)) * 10.
		print(asdf)
		skill_inst.position = asdf
		add_child(skill_inst)
		

func _physics_process(delta: float) -> void:
	
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
	
	$GeneralSkeleton.rotation.y = $SpringArmPivot.rotation.y + PI


func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(_on_cast_animation_finished)

func play_cast_animation():
	$AnimationPlayer.play("arm_raise_cast/mixamo_com")
	$AnimationPlayer.seek(0.4)
	
func _on_cast_animation_finished(anim_name: String):
	$AnimationPlayer.play("mixamo_com")
