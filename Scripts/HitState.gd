extends State

class_name HitState

@export var damageable : Damageable
@export var death_state : State
@export var return_state : State
@export var death_animation_name : String = "Death"
@export var knockback_speed : float = 100.0

@onready var timer : Timer = $Timer

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	
func on_enter():
	timer.start()

func on_damageable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	if (damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", death_state)
		playback.travel(death_animation_name)

func _on_timer_timeout():
	next_state = return_state
