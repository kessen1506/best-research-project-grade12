extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options

func _ready() -> void:
	# Show main menu, hide options
	main_buttons.visible = true
	options.visible = false

	# Apply horror style to all main menu buttons
	for child in main_buttons.get_children():
		if child is Button:
			_style_horror_button(child)

# ----------------------------
# HORROR BUTTON STYLE (4.6 SAFE)
# ----------------------------
func _style_horror_button(button: Button) -> void:
	# -------- NORMAL --------
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color(0.08, 0.08, 0.1)
	normal.border_color = Color(0.25, 0.25, 0.3)
	normal.border_width_left = 2
	normal.border_width_right = 2
	normal.border_width_top = 2
	normal.border_width_bottom = 2
	normal.corner_radius_top_left = 6
	normal.corner_radius_top_right = 6
	normal.corner_radius_bottom_left = 6
	normal.corner_radius_bottom_right = 6
	button.add_theme_stylebox_override("normal", normal)

	# -------- HOVER / FOCUS --------
	var hover := StyleBoxFlat.new()
	hover.bg_color = Color(0.12, 0.12, 0.15)
	hover.border_color = Color(0.7, 0.1, 0.1) # blood red
	hover.border_width_left = 3
	hover.border_width_right = 3
	hover.border_width_top = 3
	hover.border_width_bottom = 3
	hover.corner_radius_top_left = 6
	hover.corner_radius_top_right = 6
	hover.corner_radius_bottom_left = 6
	hover.corner_radius_bottom_right = 6
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("focus", hover)

	# -------- PRESSED --------
	var pressed := StyleBoxFlat.new()
	pressed.bg_color = Color(0.15, 0.05, 0.05)
	pressed.border_color = Color(0.9, 0.15, 0.15)
	pressed.border_width_left = 3
	pressed.border_width_right = 3
	pressed.border_width_top = 3
	pressed.border_width_bottom = 3
	pressed.corner_radius_top_left = 6
	pressed.corner_radius_top_right = 6
	pressed.corner_radius_bottom_left = 6
	pressed.corner_radius_bottom_right = 6
	button.add_theme_stylebox_override("pressed", pressed)

	# -------- TEXT --------
	button.add_theme_color_override("font_color", Color(0.75, 0.75, 0.75))
	button.add_theme_color_override("font_hover_color", Color(1.0, 0.85, 0.85))
	button.add_theme_color_override("font_pressed_color", Color(1.0, 0.3, 0.3))
	button.add_theme_font_size_override("font_size", 20)

	# Optional horror feel
	button.text = button.text.to_upper()

# ----------------------------
# BUTTON HANDLERS
# ----------------------------
func _on_game_start_pressed() -> void:
	get_tree().change_scene_to_file("res://script/Wellcome To au.tscn")

func _on_game_start_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/wellcome_to_peace.tscn")

func _on_button_2_pressed() -> void:
	main_buttons.visible = false
	options.visible = true

func _on_back_options_pressed() -> void:
	options.visible = false
	main_buttons.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_game_start_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/wellcome_to_Java_peace.tscn")

func _on_game_start_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/wellcome_to_Java.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

# ----------------------------
# PLACEHOLDERS
# ----------------------------
