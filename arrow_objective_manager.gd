extends Node

var total_arrows = 0
var collected_arrows = 0

signal arrow_collected(current, total)
signal all_arrows_collected

func _ready():
	add_to_group("ArrowManager")
	await get_tree().process_frame
	count_arrows()

func count_arrows():
	var arrows = get_tree().get_nodes_in_group("CollectibleArrow")
	total_arrows = arrows.size()
	print("[ArrowManager] Total arrows: ", total_arrows)

func collect_arrow():
	collected_arrows += 1
	print("[ArrowManager] Collected: ", collected_arrows, "/", total_arrows)
	arrow_collected.emit(collected_arrows, total_arrows)
	
	if collected_arrows >= total_arrows:
		print("[ArrowManager] 🎉 ALL ARROWS COLLECTED!")
		all_arrows_collected.emit()

func get_progress() -> String:
	return str(collected_arrows) + "/" + str(total_arrows)
