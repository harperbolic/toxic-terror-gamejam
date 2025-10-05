extends Node

@export var audio_bus_name : String

var music_bus_id
var sfx_bus_id

func _ready() -> void:
	# create references
	music_bus_id = AudioServer.get_bus_index("Music")
	sfx_bus_id = AudioServer.get_bus_index("SFX")
	
	# load saves values from definitions
	AudioServer.set_bus_volume_db(music_bus_id, DEF.settings_save["mus_volume"])
	AudioServer.set_bus_volume_db(sfx_bus_id, DEF.settings_save["sfx_volume"])

func _on_music_control_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(music_bus_id, db)

func _on_sfx_control_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(sfx_bus_id, db)
