extends Area2D

class_name Sword

@export var damage : float = 10

func _ready():
	monitoring = false

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			child.hit(damage)
