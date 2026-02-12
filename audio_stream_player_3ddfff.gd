extends AudioStreamPlayer3D

func _ready() -> void:
	loop_play()

func loop_play() -> void:
	while true:
		play()
		await finished           
		await get_tree().create_timer(20.0).timeout  
