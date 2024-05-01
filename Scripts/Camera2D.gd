extends Camera2D

# The maximum y-coordinate the camera can reach
@export var max_y_down = 700
@export var max_x_left = -200

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the current position of the camera
	var current_pos = global_position
	
	# Ensure that the camera cannot go below the maximum y-coordinate
	if current_pos.y > max_y_down:
		current_pos.y = max_y_down
		
	if current_pos.x < max_x_left:
		current_pos.x = max_x_left
	
	# Set the updated position of the camera
	global_position = current_pos
