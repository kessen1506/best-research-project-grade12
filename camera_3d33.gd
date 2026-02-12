extends Camera3D

@export var speed: float = 1.0

# Coordinates from your image
var target_position: Vector3 = Vector3(71.679, 0.600, 51.555)

func _process(delta: float) -> void:
	# Calculate the distance to the target
	if global_position.distance_to(target_position) > 0.001:
		# Moving at a constant, slow speed
		global_position = global_position.move_toward(target_position, speed * delta)
	else:
		# Snap exactly to target and stop processing
		global_position = target_position
		set_process(false)
