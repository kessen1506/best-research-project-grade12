extends Node3D

@export var objective_name = "Meowl"
@export var rotation_speed = 1.0

var collect_sound: AudioStream = preload("res://Scenes/Meow Sound Effect.mp3")

var is_collected = false
@onready var area_3d = $Area3D
@onready var audio_player = $AudioStreamPlayer

func _ready():
	add_to_group("Meowl")
	
	if area_3d:
		area_3d.body_entered.connect(_on_body_entered)

func _physics_process(delta):
	if not is_collected:
		rotate_y(rotation_speed * delta)

func _on_body_entered(body):
	if (body.name == "Player" or body is CharacterBody3D) and not is_collected:
		collect()

func collect():
	is_collected = true
	
	# Find manager and notify
	var manager = get_tree().get_first_node_in_group("MeowlManager")
	if manager:
		manager.collect_meowl()
		print("[Meowl] Notified manager")
	else:
		print("[Meowl] ERROR: Manager not found!")
	
	# Play sound
	if audio_player and collect_sound:
		audio_player.stream = collect_sound
		audio_player.play()
	
	# Make invisible
	visible = false
	area_3d.monitoring = false
	area_3d.monitorable = false
	
	# Wait for sound then delete
	if audio_player:
		await audio_player.finished
	
	queue_free()
