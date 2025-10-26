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

var save : Dictionary = {
	"level" : 0,
	"reputation" : 2.3,
	"balance" : 0
}

var username : Dictionary

# LOCALIZATION FILES
var UI_text : Dictionary
var Stage0 : Dictionary
var Stage1_C1 : Dictionary
var Stage1_C2 : Dictionary
var Stage1_C3 : Dictionary
var Stage1_C4_fail : Dictionary
var Stage1_C4_success : Dictionary
var Stage1_C_call : Dictionary
var Stage1_H1 : Dictionary

var access

const cart_reset : Dictionary = {
	"miojo" : 0,
	"chocolate" : 0,
	"beer" : 0,
	"milk" : 0,
	"energy" : 0
}

const drinks_reset : Dictionary = {
	"Orange" : 0,
	"Maracuja" : 0,
	"HotChocolate" : 0,
	"BlackCoffee" : 0,
	"Cappuccino" : 0,
	"Afogatto" : 0,
	"Espresso" : 0,
	"Pingado" : 0,
}

const food_reset : Dictionary = {
	"HotLunch" : 0,
	"Tostex" : 0,
	"Katsu" : 0,
	"Bauru" : 0,
	"Choripan" : 0,
	"Sausage" : 0,
	"Ham" : 0
}

const meds_reset : Dictionary = {
	"SleepingPills" : 0,
	"Condom" : 0,
	"Syrup" : 0,
	"Razor" : 0,
}

const extra_reset : Dictionary = {
	"Camera" : 0,
	"Cigarette" : 0,
	"Gummy" : 0
}

var current_cart : Dictionary
var record : Dictionary
var illness : Dictionary
var posts : Dictionary

func _ready() -> void:
	load_save_setting()
	load_save()
	
	selected_language = settings_save.get("language")
	
	load_locale()

func save_game() -> void:
	access = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	access.store_string(JSON.stringify(save))
	access.close()

func load_save_setting() -> void:
	if FileAccess.file_exists(CONFIG_PATH):
		access = FileAccess.open(CONFIG_PATH, FileAccess.READ)
		settings_save = JSON.parse_string(access.get_as_text())
		access.close()

func load_save() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		access = FileAccess.open(SAVE_PATH, FileAccess.READ)
		save = JSON.parse_string(access.get_as_text())
		access.close()

func load_locale():
	load_ui_locale()
	load_text_locale()

func load_ui_locale():
	access = FileAccess.open("res://text/" + selected_language + "/UI.json", FileAccess.READ)
	UI_text = JSON.parse_string(access.get_as_text())
	access.close()

func load_text_locale():
	# Stage 0 - Intermission
	access = FileAccess.open("res://text/" + selected_language + "/Stage0.json", FileAccess.READ)
	Stage0 = JSON.parse_string(access.get_as_text())
	access.close()
	
	# Character usernames
	access = FileAccess.open("res://text/" + selected_language + "/username.json", FileAccess.READ)
	username = JSON.parse_string(access.get_as_text())
	access.close()
	
	# Posts
	access = FileAccess.open("res://text/" + selected_language + "/posts.json", FileAccess.READ)
	posts = JSON.parse_string(access.get_as_text())
	access.close()
	
	# Load illness and record
	access = FileAccess.open("res://text/" + selected_language + "/illness.json", FileAccess.READ)
	illness = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/crimes.json", FileAccess.READ)
	record = JSON.parse_string(access.get_as_text())
	access.close()
	
	# Stage 1
	access = FileAccess.open("res://text/" + selected_language + "/Stage1_C1.json", FileAccess.READ)
	Stage1_C1 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage1_C2.json", FileAccess.READ)
	Stage1_C2 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage1_C3.json", FileAccess.READ)
	Stage1_C3 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage1_C4_fail.json", FileAccess.READ)
	Stage1_C4_fail= JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage1_C4_success.json", FileAccess.READ)
	Stage1_C4_success = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage1_C_call.json", FileAccess.READ)
	Stage1_C_call = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage1_H1.json", FileAccess.READ)
	Stage1_H1 = JSON.parse_string(access.get_as_text())
	access.close()
