extends Node

const CONFIG_PATH : String = "user://config.json"
const save_path : String= "user://saves/"
const save1 : String  = "0.json"
const save2 : String  = "1.json"
const save3 : String  = "2.json"
const save4 : String  = "3.json"
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

var game_states = {
	"level" : 0,
	"reputation" : 2.8,
	"itens_delivered" : 0,
	"errors" : 0
}

func _ready() -> void:
	load_save_setting()

func load_save_setting() -> void:
	if FileAccess.file_exists(CONFIG_PATH):
		var access = FileAccess.open(CONFIG_PATH, FileAccess.READ)
		settings_save = JSON.parse_string(access.get_as_text())
		access.close()
