extends Node

const CONFIG_PATH : String = "user://config.json"
const SAVE_PATH : String= "user://saves/"
const TEXT_PATH : String = "res://text"

var resolutions = {
	"3840 x 2160" : Vector2i(3840, 2160),
	"2560 x 1440" : Vector2i(2560, 1440),
	"1920 x 1080" : Vector2i(1920, 1080),
	"1440 x 900" : Vector2i(1440, 900),
	"1366 x 768" : Vector2i(1366, 768),
	"1280 x 720" : Vector2i(1280, 720)
}

var language = {
	"English" : "en",
	"Português" : "pt"
}

var selected_language = language.get("English")

var settings_save = {
	"sfx_volume" : 0,
	"mus_volume" : 0,
	"fullscreen" : true,
	"resolution" : "1920 x 1080",
	"language" : "English",
	"debug" : true
}

var game_boilerplate : Dictionary = {
	"level" : 0,
	"reputation" : 2.8,
	"balance" : 0
}

var current_save : Dictionary

var current_save_id : String

func _ready() -> void:
	load_save_setting()

func load_save_setting() -> void:
	if FileAccess.file_exists(CONFIG_PATH):
		var access = FileAccess.open(CONFIG_PATH, FileAccess.READ)
		settings_save = JSON.parse_string(access.get_as_text())
		access.close()

func new_game(id : String) -> void:
	var access = FileAccess.open(SAVE_PATH + id + ".json", FileAccess.WRITE)
	access.store_string(JSON.stringify(data))
	

func load_save(id : String) -> void:
	if FileAccess.file_exists(SAVE_PATH + id + ".json"):
		var access = FileAccess.open(SAVE_PATH + id + ".json", FileAccess.READ)
		# save_load = JSON.parse_string(access.get_as_text())
		access.close()
