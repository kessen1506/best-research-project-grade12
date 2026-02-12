extends Node

var total_meowls = 0
var collected_meowls = 0

signal meowl_collected(current, total)
signal all_meowls_collected

func _ready():
	print("[Manager] Manager started")
	# Add to group so meowls can find us
	add_to_group("MeowlManager")
	print("[Manager] Added to MeowlManager group")
	
	# Count all meowls in this scene
	await get_tree().process_frame
	await get_tree().process_frame  # Wait extra frame
	count_meowls()

func count_meowls():
	print("[Manager] Counting meowls...")
	
	# Find all Meowl nodes in the scene
	var meowls = get_tree().get_nodes_in_group("Meowl")
	total_meowls = meowls.size()
	
	print("[Manager] Found meowls: ", meowls)
	print("[Manager] Total meowls in scene: ", total_meowls)
	
	# List each meowl
	for meowl in meowls:
		print("[Manager] - ", meowl.name)

func collect_meowl():
	collected_meowls += 1
	print("[Manager] Collected: ", collected_meowls, "/", total_meowls)
	meowl_collected.emit(collected_meowls, total_meowls)
	
	if collected_meowls >= total_meowls:
		print("[Manager] 🎉 ALL MEOWLS COLLECTED IN THIS SCENE!")
		all_meowls_collected.emit()

func get_progress() -> String:
	return str(collected_meowls) + "/" + str(total_meowls)
