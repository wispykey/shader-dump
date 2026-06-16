extends CharacterBody3D
@export var acceleration: float = 100.
@export var max_speed: float = 100.
@export var camera: Node3D

@export var skill: PackedScene

@onready var ilyana: Ilyana = $Ilyana

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hotbar_1_skill_1"):
		ilyana.play_cast_animation()
		var skill_inst = skill.instantiate()
		skill_inst.position = $SpringArmPivot/Camera3D.position
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
