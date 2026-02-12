extends Button

@onready var options_panel: Panel = $"../Control/Options"
@onready var pause_panel: Panel = $"../Control/Paused"

func _ready() -> void:
	# Start unpaused and hide menus
	get_tree().paused = false
	if options_panel:
		options_panel.visible = false
	if pause_panel:
		pause_panel.visible = false

	process_mode = Node.PROCESS_MODE_ALWAYS
	pressed.connect(_on_settings_pressed)

	# === STYLE DESIGN ===
	var btn_normal := StyleBoxFlat.new()
	btn_normal.bg_color = Color(0.2, 0.2, 0.2)
	btn_normal.set_corner_radius_all(8)

	var btn_hover := StyleBoxFlat.new()
	btn_hover.bg_color = Color(0.35, 0.35, 0.35)
	btn_hover.set_corner_radius_all(8)

	var btn_pressed := StyleBoxFlat.new()
	btn_pressed.bg_color = Color(0.1, 0.1, 0.1)
	btn_pressed.set_corner_radius_all(8)

	add_theme_stylebox_override("normal", btn_normal)
	add_theme_stylebox_override("hover", btn_hover)
	add_theme_stylebox_override("pressed", btn_pressed)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			# Resume game
			get_tree().paused = false
			if pause_panel:
				pause_panel.visible = false
			if options_panel:
				options_panel.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			
			get_tree().paused = true
			if pause_panel:
				pause_panel.visible = true
			if options_panel:
				options_panel.visible = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_settings_pressed() -> void:
	# Pause the game and show Options
	get_tree().paused = true
	if options_panel:
		options_panel.visible = true
	if pause_panel:
		pause_panel.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
