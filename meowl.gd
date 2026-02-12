extends Node3D

signal collected

@onready var hitbox = $Area3D
var player_in_range := false

func _ready():
	hitbox.body_entered.connect(_on_body_entered)
	hitbox.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true
		print("Player near Meowl — press E to collect")

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false
		print("Player left Meowl")

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		collected.emit()
		queue_free()
