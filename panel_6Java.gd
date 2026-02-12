extends Panel

@export var correct_answer: String = "AnswerC"

func _ready() -> void:
	visible = false
	# Panel styling
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
	
	# Question label
	$Label.text = "Go to Right Room to see the Question"
	$Label.add_theme_color_override("font_color", Color.WHITE)
	$Label.add_theme_font_size_override("font_size", 22)
	
	# Button setup
	_style_button($VBoxContainer/Button, "result: true, x: 6")
	_style_button($VBoxContainer/Button2, "result: false, x: 6")
	_style_button($VBoxContainer/Button3, "result: false, x: 5")
	_style_button($VBoxContainer/Button4, "result: true, x: 5")
	
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

func play_correct_sound() -> void:
	if $CorrectSound:
		$CorrectSound.play()

func play_wrong_sound() -> void:
	if $WrongSound:
		$WrongSound.play()

# Button handlers
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
		get_tree().change_scene_to_file("res://Scenes/vent_Java.tscn")
	else:
		play_wrong_sound()
		button.add_theme_color_override("font_color", Color.RED)
		
		# Additional visual feedback: flash the button red
		var original_modulate = button.modulate
		var tween = create_tween()
		tween.tween_property(button, "modulate", Color.RED, 0.2)
		tween.tween_property(button, "modulate", original_modulate, 0.2)
		
		# Shake effect
		var original_position = button.position
		var shake_tween = create_tween()
		shake_tween.tween_property(button, "position:x", original_position.x - 5, 0.05)
		shake_tween.tween_property(button, "position:x", original_position.x + 5, 0.05)
		shake_tween.tween_property(button, "position:x", original_position.x - 5, 0.05)
		shake_tween.tween_property(button, "position:x", original_position.x + 5, 0.05)
		shake_tween.tween_property(button, "position:x", original_position.x, 0.05)
		
		# Apply 35-second penalty with improved search
		var countdown_control = find_countdown_timer()
		if countdown_control:
			countdown_control.reduce_time(35.0)
			print("Successfully reduced timer by 35 seconds!")
		else:
			print("ERROR: Could not find CountdownTimer Control node!")

# IMPROVED: More specific search that checks node type
func find_countdown_timer():
	# Method 1: Search by group (most reliable)
	var nodes = get_tree().get_nodes_in_group("timer_controller")
	for node in nodes:
		# Make sure it's a Control node with reduce_time method
		if node is Control and node.has_method("reduce_time"):
			print("Found timer controller: ", node.name)
			return node
	
	# Method 2: Search for Control nodes with CountdownTimer child
	var root = get_tree().root
	var result = search_for_timer_control(root)
	if result:
		print("Found timer controller via search: ", result.name)
		return result
	
	print("ERROR: No valid timer controller found!")
	return null

# Recursive search specifically for Control nodes with reduce_time method
func search_for_timer_control(node):
	# Check if this node is a Control with reduce_time method
	if node is Control and node.has_method("reduce_time"):
		# Double-check it has a CountdownTimer child
		if node.has_node("CountdownTimer"):
			return node
	
	# Search children
	for child in node.get_children():
		var result = search_for_timer_control(child)
		if result:
			return result
	
	return null

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_R:
		visible = false
