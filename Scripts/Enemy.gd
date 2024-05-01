extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var character_state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var sprite : Sprite2D = $Sprite2D

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var speed : float = 25.0
@export var death_animation_name : String = "Death"
@export var hit_state : State
@export var death_state : State
@export var player : Player
@export var threshold : float = 200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the direction to the player.
	var direction_to_player = (player.global_position - global_position).normalized()
	var distance_from_player = (player.global_position - global_position)
	
	print(distance_from_player.x)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# Check if the player is within the movement threshold distance
	if (distance_from_player.x < threshold && distance_from_player.x > 0):
		if character_state_machine.check_if_can_move():
			velocity.x = direction_to_player.x * speed
		elif character_state_machine.current_state != hit_state:
			velocity.x = move_toward(velocity.x, 0, speed)
	elif (distance_from_player.x > -threshold && distance_from_player.x < 0):
		if character_state_machine.check_if_can_move():
			velocity.x = direction_to_player.x * speed
		elif character_state_machine.current_state != hit_state:
			velocity.x = move_toward(velocity.x, 0, speed)
	else:
		velocity.x = 0

	move_and_slide()
	update_facing_direction()
	
func update_facing_direction():
	# Get the direction to the player.
	var direction_to_player = (player.global_position - global_position).normalized()
	if (character_state_machine.current_state != death_state):
		if direction_to_player.x > 0:
			sprite.flip_h = true
		elif direction_to_player.x < 0:
			sprite.flip_h = false
