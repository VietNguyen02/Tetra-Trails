extends CharacterBody2D

class_name Player

@export var speed : float = 200.0
@export var health : int = 3
@export var death_state : State
@export var death_animation_name : String = "Death"

# Animation Child Object reference
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var collision_shape : CollisionShape2D = $PlayerArea2D/PlayerCollisionHitbox

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO
var playback : AnimationNodeStateMachinePlayback

signal facing_direction_changed(facing_right : bool)
signal health_changed

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	#print(position)

	update_animation()
	update_facing_direction()
	move_and_slide()
	check_in_bounds()

func _input(event : InputEvent):
	# Logic for going down one-way platforms
	if (event.is_action_pressed("ui_down") && is_on_floor()):
		position.y += 2.5
		
func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_facing_direction():
	if (state_machine.current_state != death_state):
		if direction.x > 0:
			sprite.flip_h = false
		elif direction.x < 0:
			sprite.flip_h = true
		emit_signal("facing_direction_changed", !sprite.flip_h)
	
func takeDamage(damage : int):
	health -= damage

func _on_player_area_2d_area_entered(area):
	if (area.is_in_group("Enemy") && health > 1):
		takeDamage(1)
	else:
		takeDamage(1)
		state_machine.switch_states(death_state)
	
	health_changed.emit(health)
	
func check_in_bounds():
	if (position.y >= 900):
		get_tree().change_scene_to_file("res://UI/DefeatScreen.tscn")
