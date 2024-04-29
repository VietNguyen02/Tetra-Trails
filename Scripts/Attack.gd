extends State

class_name AttackState

@export var ground_state : State
@export var return_animation_name : String = "Move"
@export var attack1_name : String = "Attack1"
@export var attack2_name : String = "Attack2"

# Timer for window to perform another attack
@onready var timer : Timer = $Timer

func state_input(event : InputEvent):
	if (event.is_action_pressed("Attack")):
		timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == attack1_name):
		if (timer.is_stopped()):
			next_state = ground_state
			playback.travel(return_animation_name)
		else:
			playback.travel(attack2_name)
	if (anim_name == attack2_name):
		next_state = ground_state
		playback.travel(return_animation_name)
