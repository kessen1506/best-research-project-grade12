extends Panel

@onready var pause_panel: Panel = $"../Paused"

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

	var panel_style := StyleBoxFlat.new()
	panel_style.bg_color = Color(0.02, 0.02, 0.02, 0.85)
	panel_style.border_color = Color(0.45, 0.05, 0.05)
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(4)
	add_theme_stylebox_override("panel", panel_style)

	var btn_normal := StyleBoxFlat.new()
	btn_normal.bg_color = Color(0.08, 0.08, 0.08)
	btn_normal.border_color = Color(0.3, 0.0, 0.0)
	btn_normal.set_border_width_all(1)
	btn_normal.set_corner_radius_all(2)

	var btn_hover := StyleBoxFlat.new()
	btn_hover.bg_color = Color(0.18, 0.02, 0.02)
	btn_hover.border_color = Color(0.9, 0.15, 0.15)
	btn_hover.set_border_width_all(2)
	btn_hover.set_corner_radius_all(2)

	var btn_pressed := StyleBoxFlat.new()
	btn_pressed.bg_color = Color(0.05, 0.0, 0.0)
	btn_pressed.border_color = Color(0.6, 0.0, 0.0)
	btn_pressed.set_border_width_all(1)
	btn_pressed.set_corner_radius_all(2)

	_apply_styles_recursively(self, btn_normal, btn_hover, btn_pressed)


func _apply_styles_recursively(
	node: Node,
	btn_normal: StyleBoxFlat,
	btn_hover: StyleBoxFlat,
	btn_pressed: StyleBoxFlat
) -> void:
	if node is Button:
		node.add_theme_stylebox_override("normal", btn_normal)
		node.add_theme_stylebox_override("hover", btn_hover)
		node.add_theme_stylebox_override("pressed", btn_pressed)

		node.add_theme_color_override("font_color", Color(0.85, 0.85, 0.85))
		node.add_theme_color_override("font_hover_color", Color(1.0, 0.35, 0.35))
		node.add_theme_color_override("font_pressed_color", Color(0.7, 0.1, 0.1))

	for child in node.get_children():
		_apply_styles_recursively(child, btn_normal, btn_hover, btn_pressed)


func _on_back_pressed() -> void:
	visible = false


	if pause_panel:
		pause_panel.visible = true
