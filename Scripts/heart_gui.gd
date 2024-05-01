extends Panel

@onready var sprite = $HeartSprite

func update (whole : bool):
	if whole: sprite.frame = 4
	else: sprite.frame = 0
		
