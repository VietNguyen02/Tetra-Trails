extends CharacterBody2D

class_name Collectible

func _on_collectible_area_2d_area_entered(area):
	if (area.is_in_group("Player")):
		print("Collision Detected")
		get_tree().change_scene_to_file("res://UI/VictoryScreen.tscn")
