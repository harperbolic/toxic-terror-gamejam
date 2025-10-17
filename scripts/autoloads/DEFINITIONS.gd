extends Node

const CONFIG_PATH : String = "user://config.json"
const SAVE_PATH : String= "user://save.json"
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

var selected_language = "en"

var settings_save = {
	"sfx_volume" : 0,
	"mus_volume" : 0,
	"fullscreen" : true,
	"resolution" : "1920 x 1080",
	"language" : "en",
	"debug" : true
}

var game_boilerplate : Dictionary = {
	"level" : 0,
	"reputation" : 2.3,
	"balance" : 0
}

var save : Dictionary

# LOCALIZATION FILES
var UI_text : Dictionary
var Stage0 : Dictionary

func _ready() -> void:
	load_save_setting()
	load_save()
	
	selected_language = settings_save.get("language")
	
	load_locale()

func save_game() -> void:
	var access = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	access.store_string(JSON.stringify(save))
	access.close()

func load_save_setting() -> void:
	if FileAccess.file_exists(CONFIG_PATH):
		var access = FileAccess.open(CONFIG_PATH, FileAccess.READ)
		settings_save = JSON.parse_string(access.get_as_text())
		access.close()

func load_save() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var access = FileAccess.open(SAVE_PATH, FileAccess.READ)
		save = JSON.parse_string(access.get_as_text())
		access.close()

func load_locale():
	load_ui_locale()
	load_stage0()

func load_ui_locale():
	var access = FileAccess.open("res://text/" + selected_language + "/UI.json", FileAccess.READ)
	UI_text = JSON.parse_string(access.get_as_text())
	access.close()

func load_stage0():
	var access = FileAccess.open("res://text/" + selected_language + "/Stage0.json", FileAccess.READ)
	Stage0 = JSON.parse_string(access.get_as_text())
	access.close()
