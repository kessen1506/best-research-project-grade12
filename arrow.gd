extends Node3D

@export var rotation_speed = 1.0
@export var bob_height: float = 0.2
@export var bob_speed: float = 2.0

var collect_sound: AudioStream
var bob_offset: float = 0.0
var is_collected = false
var initial_y: float = 0.0  # Store starting height

@onready var area_3d = $Area3D
@onready var audio_player = $AudioStreamPlayer

func _ready():
	add_to_group("CollectibleArrow")
	
	# Store the initial Y position from the editor
	initial_y = position.y
	
	if area_3d:
		area_3d.body_entered.connect(_on_body_entered)
	
	start_bobbing()

func start_bobbing():
	var tween = create_tween().set_loops()
	tween.tween_property(self, "bob_offset", bob_height, bob_speed / 2.0)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "bob_offset", 0.0, bob_speed / 2.0)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)

func _physics_process(delta):
	if not is_collected:
		# Rotate
		rotate_y(rotation_speed * delta)
		
		# Apply bobbing from initial position
		position.y = initial_y + bob_offset

func _on_body_entered(body):
	if (body.name == "Player" or body is CharacterBody3D) and not is_collected:
		collect()

func collect():
	is_collected = true
	
	var manager = get_tree().get_first_node_in_group("ArrowManager")
	if manager:
		manager.collect_arrow()
		print("[Arrow] Notified manager")
	else:
		print("[Arrow] ERROR: Manager not found!")
	
	if audio_player and collect_sound:
		audio_player.stream = collect_sound
		audio_player.play()
	
	visible = false
	area_3d.monitoring = false
	area_3d.monitorable = false
	
	if audio_player:
		await audio_player.finished
	
	queue_free()
