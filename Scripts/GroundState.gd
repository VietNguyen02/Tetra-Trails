extends State

class_name GroundState

# Air State
@export var air_state : State
@export var jump_animation : String = "Jump_Start"
@export var jump_velocity = -125.0
# Attack State
@export var attack_state : State
@export var attack_animation : String = "Attack1"

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	if (event.is_action_pressed("Attack")):
		attack()
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
	playback.travel(attack_animation)
