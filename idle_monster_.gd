extends Node3D

@onready var anim_player = $AnimationPlayer
@onready var hitbox = $Area3D

func _ready():
	if anim_player and anim_player.has_animation("mixamo_com"):
		anim_player.play("mixamo_com")
	
	if hitbox:
		hitbox.body_entered.connect(_on_player_touched)

func _on_player_touched(body):
	if body.name == "Player" or body is CharacterBody3D:
		trigger_jumpscare()

func trigger_jumpscare():
	if anim_player and anim_player.has_animation("mixamo_com"):
		anim_player.play("mixamo_com")
	
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()
