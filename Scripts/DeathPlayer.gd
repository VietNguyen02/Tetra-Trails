extends State

class_name DeathPlayer

@export var death_animation_name : String = "Death"

func on_enter():
	playback.travel(death_animation_name)
