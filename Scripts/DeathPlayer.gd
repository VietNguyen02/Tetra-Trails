extends State

class_name DeathPlayer

@export var death_animation_name : String = "Death"

func on_enter():
	playback.travel(death_animation_name)

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == death_animation_name):
		get_tree().change_scene_to_file("res://UI/DefeatScreen.tscn")
