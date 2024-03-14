extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity = -125.0
@export var double_jump_velocity = -100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped: bool= false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		# Single jump off floor
		if is_on_floor():
			velocity.y = jump_velocity
		# Double jump off first jump
		elif not has_double_jumped:
			velocity.y = double_jump_velocity
			has_double_jumped = true
			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()