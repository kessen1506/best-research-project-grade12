extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var animation_player = find_child("AnimationPlayer", true)  # Recursively search for AnimationPlayer in the scene tree
	if animation_player:
		var animations = animation_player.get_animation_list()
		if not animations.is_empty():
			# Print available animations for debugging
			print("Found ", animations.size(), " animation(s):")
			for anim_name in animations:
				print(" - ", anim_name)
			# Set loop mode for all animations
			for anim_name in animations:
				var anim = animation_player.get_animation(anim_name)
				if anim:
					anim.loop_mode = Animation.LOOP_LINEAR  # Set to loop continuously
			# Play the second animation 'elevation_axisAction' (assuming it's more visible)
			var target_animation = "elevation_axisAction"
			if target_animation in animations:
				animation_player.play(target_animation)
				print("Now playing (looped): ", target_animation)
			else:
				print("Target animation not found, playing first one")
				animation_player.play(animations[0])
		else:
			print("No animations found in AnimationPlayer")
	else:
		print("AnimationPlayer node not found in the scene tree")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
