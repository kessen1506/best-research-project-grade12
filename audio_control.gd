extends Node

var audio_bus_volumes := {}
var audio_bus_id: int

func set_volume(bus_name: String, value: float) -> void:
	var db = linear_to_db(value)
	var bus_id = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_id, db)
	audio_bus_volumes[bus_name] = value

func get_volume(bus_name: String) -> float:
	return audio_bus_volumes.get(bus_name, 1.0) # default full volume

func _on_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
