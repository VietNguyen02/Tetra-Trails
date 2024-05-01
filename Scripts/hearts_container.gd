extends HBoxContainer

class_name HeartsContainer

@onready var HeartGUIClass = preload("res://UI/heart_gui.tscn")

func setMaxHearts(max : int):
	for i in range(max):
		var heart = HeartGUIClass.instantiate()
		add_child(heart)

func update_hearts (current_health : int):
	var hearts = get_children()
	
	for i in range (current_health):
		hearts[i].update(true)
	
	for i in range (current_health, hearts.size()):
		hearts[i].update(false)
