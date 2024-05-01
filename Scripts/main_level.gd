extends Node2D

class_name MainLevel

@onready var hearts_container : HeartsContainer = $CanvasLayer/HeartsContainer
@onready var player : Player = $Player

func _ready():
	hearts_container.setMaxHearts(player.health)
	hearts_container.update_hearts(player.health)
	player.health_changed.connect(hearts_container.update_hearts)
