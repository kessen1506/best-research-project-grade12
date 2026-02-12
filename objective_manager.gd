extends Node2D

var total_meowls: int = 0
var collected_meowls: int = 0

@onready var hud_label: Label = $HUD/MeowlCounter  # optional, if you add a Label node

func _ready() -> void:
	# Find all Meowls in the scene
	var meowls = get_tree().get_nodes_in_group("Meowls")
	total_meowls = meowls.size()
	collected_meowls = 0

	# Connect each Meowl's collected signal
	for meowl in meowls:
		if meowl.has_signal("collected"):
			meowl.connect("collected", Callable(self, "_on_meowl_collected"))

	# Update HUD at start
	_update_hud()

func _on_meowl_collected() -> void:
	collected_meowls += 1
	print("Meowls found: %d/%d" % [collected_meowls, total_meowls])
	_update_hud()

	if collected_meowls == total_meowls:
		print("🎉 You found all Meowls!")
		if hud_label:
			hud_label.text = "🎉 You found all Meowls!"

func _update_hud() -> void:
	if hud_label:
		hud_label.text = "Meowls: %d/%d" % [collected_meowls, total_meowls]
