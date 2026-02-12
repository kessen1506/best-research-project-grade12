extends Control

@onready var countdown_timer = $CountdownTimer
@onready var timer_label = $TimerLabel
var time_penalty: float = 0.0

func _ready():
	# CRITICAL: Add to group so panels can find this node
	add_to_group("timer_controller")
	
	countdown_timer.start()
	countdown_timer.connect("timeout", Callable(self, "_on_CountdownTimer_timeout"))

func _process(delta):
	var time_left = max(0, int(countdown_timer.time_left - time_penalty))
	var minutes = time_left / 60
	var seconds = time_left % 60
	timer_label.text = "%02d:%02d" % [minutes, seconds]
	
	if time_left <= 0 and countdown_timer.time_left > 0:
		_on_CountdownTimer_timeout()

func _on_CountdownTimer_timeout():
	get_tree().change_scene_to_file("res://Jumpscare_peace.tscn")

# THIS FUNCTION IS REQUIRED - without it, panels can't reduce time
func reduce_time(seconds: float) -> void:
	time_penalty += seconds
	print("Time penalty increased by ", seconds, " seconds. Total penalty: ", time_penalty)
