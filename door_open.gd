extends Node2D

@onready var video_player = $VideoStreamPlayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	video_player.play()
	
	video_player.connect("finished", Callable(self, "_on_video_finished"))

func _on_video_finished():
	get_tree().change_scene_to_file("res://Scenes/room2.tscn")
