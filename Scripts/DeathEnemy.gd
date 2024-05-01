extends State

class_name DeathState

@export var death_animation_name : String = "Death"
@export var character_state_machine : CharacterStateMachine

func _on_enemy_area_2d_area_entered(area):
	if (area.is_in_group("Player")):
		character_state_machine.switch_states(self)
		playback.travel(death_animation_name)
