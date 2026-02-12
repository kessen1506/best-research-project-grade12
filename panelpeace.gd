extends Panel

var correct_answer: String = "AnswerB"

func _ready() -> void:
	visible = false   

	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.1, 0.1, 0.15)
	panel_style.border_color = Color(0.3, 0.6, 1.0)
	panel_style.border_width_left = 3
	panel_style.border_width_right = 3
	panel_style.border_width_top = 3
	panel_style.border_width_bottom = 3
	panel_style.corner_radius_top_left = 12
	panel_style.corner_radius_top_right = 12
	panel_style.corner_radius_bottom_left = 12
	panel_style.corner_radius_bottom_right = 12
	add_theme_stylebox_override("panel", panel_style)
	
	$Label.text = "What is the purpose of #include <stdio.h> in a C program?"
	$Label.add_theme_color_override("font_color", Color.WHITE)
	$Label.add_theme_font_size_override("font_size", 22)
	
	_style_button($VBoxContainer/Button, "It defines the main() function")
	_style_button($VBoxContainer/Button2, "It allows the use of input/output functions like printf()")
	_style_button($VBoxContainer/Button3, "It declares variables")
	_style_button($VBoxContainer/Button4, "It connects your program directly to the operating system")
	
	$VBoxContainer/Button.pressed.connect(_on_button_pressed)
	$VBoxContainer/Button2.pressed.connect(_on_button_2_pressed)
	$VBoxContainer/Button3.pressed.connect(_on_button_3_pressed)
	$VBoxContainer/Button4.pressed.connect(_on_button_4_pressed)

func _style_button(button: Button, text: String) -> void:
	button.text = text
	
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color(0.2, 0.2, 0.25)
	normal.corner_radius_top_left = 8
	normal.corner_radius_top_right = 8
	normal.corner_radius_bottom_left = 8
	normal.corner_radius_bottom_right = 8
	button.add_theme_stylebox_override("normal", normal)
	
	var hover := StyleBoxFlat.new()
	hover.bg_color = Color(0.3, 0.5, 0.8)
	hover.corner_radius_top_left = 8
	hover.corner_radius_top_right = 8
	hover.corner_radius_bottom_left = 8
	hover.corner_radius_bottom_right = 8
	button.add_theme_stylebox_override("hover", hover)
	
	var pressed := StyleBoxFlat.new()
	pressed.bg_color = Color(0.1, 0.4, 0.6)
	pressed.corner_radius_top_left = 8
	pressed.corner_radius_top_right = 8
	pressed.corner_radius_bottom_left = 8
	pressed.corner_radius_bottom_right = 8
	button.add_theme_stylebox_override("pressed", pressed)
	
	button.add_theme_color_override("font_color", Color.WHITE)
	button.add_theme_font_size_override("font_size", 18)

# ----------------------------
# SOUND FUNCTIONS
# ----------------------------
func play_correct_sound() -> void:
	if $CorrectSound:
		$CorrectSound.play()

func play_wrong_sound() -> void:
	if $WrongSound:
		$WrongSound.play()

# ----------------------------
# BUTTON HANDLERS
# ----------------------------
func _on_button_pressed() -> void:
	check_answer("AnswerA", $VBoxContainer/Button)

func _on_button_2_pressed() -> void:
	check_answer("AnswerB", $VBoxContainer/Button2)

func _on_button_3_pressed() -> void:
	check_answer("AnswerC", $VBoxContainer/Button3)

func _on_button_4_pressed() -> void:
	check_answer("AnswerD", $VBoxContainer/Button4)

func check_answer(answer: String, button: Button) -> void:
	if answer == correct_answer:
		play_correct_sound()
		button.add_theme_color_override("font_color", Color.GREEN)
		await get_tree().create_timer(0.5).timeout
		visible = false
		var next_panel := get_parent().get_node("Panel2")
		if next_panel:
			next_panel.visible = true
	else:
		play_wrong_sound()
		button.add_theme_color_override("font_color", Color.RED)

		# Flash red
		var original_modulate := button.modulate
		var flash := create_tween()
		flash.tween_property(button, "modulate", Color.RED, 0.2)
		flash.tween_property(button, "modulate", original_modulate, 0.2)

		# Shake effect
		var original_pos := button.position
		var shake := create_tween()
		shake.tween_property(button, "position:x", original_pos.x - 5, 0.05)
		shake.tween_property(button, "position:x", original_pos.x + 5, 0.05)
		shake.tween_property(button, "position:x", original_pos.x - 5, 0.05)
		shake.tween_property(button, "position:x", original_pos.x + 5, 0.05)
		shake.tween_property(button, "position:x", original_pos.x, 0.05)

		# Apply 35-second penalty
		var countdown_control = find_countdown_timer()
		if countdown_control:
			countdown_control.reduce_time(35.0)
			print("Successfully reduced timer by 35 seconds!")
		else:
			print("ERROR: Could not find CountdownTimer Control node!")

# --------------------------------------
# ROBUST TIMER SEARCH
# --------------------------------------
func find_countdown_timer():
	# Method 1: group search (best)
	var nodes = get_tree().get_nodes_in_group("timer_controller")
	for node in nodes:
		if node.has_method("reduce_time"):
			return node

	# Method 2: recursive search
	return search_node_recursive(get_tree().root)

func search_node_recursive(node):
	if node.has_method("reduce_time"):
		return node
	for child in node.get_children():
		var result = search_node_recursive(child)
		if result:
			return result
	return null
