extends Panel  # or Control, depending on your node

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		hide()
