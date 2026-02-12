extends Node3D

@onready var area_3d = $Area3D
@onready var audio_player = $AudioStreamPlayer3D
@onready var ambience = $Ambience
@onready var sketchfab_model = $Sketchfab_model

var ghost_timer: Timer
var original_ambience_stream # Store the original ambience sound
var has_triggered = false # Track if already triggered

func _ready():
	print("=== _ready() START ===") # Debug print
	# Hide only the ghost model initially (ensures it's not visible at start)
	sketchfab_model.visible = true
	print("Ghost model hidden at start (visible = false)") # Debug print
	
	# Store the original ambience sound
	original_ambience_stream = ambience.stream
	print("Original ambience stream stored: ", original_ambience_stream) # Debug print
	
	# Load your ghost sound file here (MP3)
	audio_player.stream = load("res://Sounds/Jumpscare Sound Effect.mp3")
	if audio_player.stream:
		print("Jumpscare sound loaded successfully") # Debug print
	else:
		print("FAILED to load jumpscare sound! Check path.") # Debug print
	
	# Create and configure timer
	ghost_timer = Timer.new()
	ghost_timer.wait_time = 2.0
	ghost_timer.one_shot = true
	add_child(ghost_timer)
	ghost_timer.timeout.connect(_on_timer_timeout)
	print("Ghost timer created, wait_time=2.0, connected to _on_timer_timeout") # Debug print
	
	# Ensure Area3D is monitoring (in case it's disabled in the editor)
	area_3d.monitoring = true
	area_3d.monitorable = true
	print("Area3D monitoring/monitorable forced to true") # Debug print
	
	# Connect the body_entered signal from Area3D
	area_3d.body_entered.connect(_on_body_entered)


func _on_body_entered(_body):
	print("=== BODY ENTERED DETECTED ===") # Debug print
	print("Body name: ", _body.name) # Debug print
	print("Body type: ", _body.get_class()) # Debug print
	
	# Only trigger for the player (adjust "Player" if your player's node name is different)
	if _body.name != "Player":
		print("Not the player (", _body.name, "), ignoring trigger") # Debug print
		return
	
	print("Player confirmed! Proceeding...") # Debug print
	
	# Only trigger if it hasn't been triggered before
	if has_triggered:
		print("ALREADY triggered once, ignoring") # Debug print
		return
	
	has_triggered = true
	print("TRIGGERING GHOST NOW!") # Debug print
	
	sketchfab_model.visible = false
	print("Ghost model set visible = true") # Debug print
	
	audio_player.play()
	print("Jumpscare audio started") # Debug print
	
	ambience.stream = load("res://Sounds/zapsplat_horror_swell_mysterious_sinisher_whining_swell_ghostly_cold_eerie_003_104549.mp3")
	if ambience.stream:
		ambience.play()
		print("Horror ambience swapped and playing") # Debug print
	else:
		print("FAILED to load horror ambience!") # Debug print
	
	ghost_timer.start()
	print("Ghost timer started (2s)") # Debug print
	print("=== TRIGGER COMPLETE ===") # Debug print

func _on_timer_timeout():
	print("=== TIMER TIMEOUT (2s over) ===") # Debug print
	# Hide the ghost model after 2 seconds
	sketchfab_model.visible = false
	print("Ghost model hidden again") 
	
	# Restore the original ambience
	ambience.stream = original_ambience_stream
	ambience.play()
	print("Original ambience restored and playing")
	print("=== RESET COMPLETE ===") 
