extends Panel

func _ready():
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	

	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		resume_game()


func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		resume_game()

func resume_game():

	get_tree().paused = false
	

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
	queue_free()
