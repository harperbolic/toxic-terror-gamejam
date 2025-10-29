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

const game_boilerplate : Dictionary = {
	"level" : 0,
	"balance" : 200
}

var save : Dictionary = {
	"level" : 0,
	"balance" : 0
}

var username : Dictionary

# LOCALIZATION FILES
var UI_text : Dictionary
var Stage0 : Dictionary
var Stage1_C1 : Dictionary
var Stage1_C2 : Dictionary
var Stage1_C3 : Dictionary
var Stage1_C3_fail : Dictionary
var Stage1_C4_fail : Dictionary
var Stage1_C4_success : Dictionary
var Stage1_C_call : Dictionary
var Stage1_C_end : Dictionary
var Stage1_H1 : Dictionary

# notice
var notice : Dictionary

# Stage 2 files
var Stage2_end : Dictionary
var Stage2_failure : Dictionary
var Stage2_H1 : Dictionary
var Stage2_H2 : Dictionary
var Stage2_L : Dictionary
var Stage2_R1 : Dictionary
var Stage2_R2 : Dictionary
var Stage2_S1 : Dictionary
var Stage2_S2 : Dictionary
var Stage2_T1 : Dictionary
var Stage2_T2 : Dictionary

# items
var food_item : Dictionary
var drink_item : Dictionary
var health_item : Dictionary
var extra_item : Dictionary
var posts : Dictionary
var access

const posts_reset = {
	"post1" : false,
	"post2" : false,
	"post3" : false
}

const cart_reset = {
	"miojo" : 0,
	"chocolate" : 0,
	"beer" : 0,
	"milk" : 0,
	"energy" : 0
}

const drink_reset : Dictionary = {
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
	"Ham" : 0,
	"Director" : 0
}

const health_reset : Dictionary = {
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
var food : Dictionary
var drink : Dictionary
var health : Dictionary
var extra : Dictionary
var record : Dictionary
var illness : Dictionary
var posts_register : Dictionary
var dialog : Dictionary

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
	load_items_locale()
	load_text_locale()

func load_ui_locale():
	access = FileAccess.open("res://text/" + selected_language + "/UI.json", FileAccess.READ)
	UI_text = JSON.parse_string(access.get_as_text())
	access.close()

func load_items_locale():
	access = FileAccess.open("res://text/" + selected_language + "/drink_item.json", FileAccess.READ)
	drink_item = JSON.parse_string(access.get_as_text())
	access.close()
	
	access = FileAccess.open("res://text/" + selected_language + "/food_item.json", FileAccess.READ)
	food_item = JSON.parse_string(access.get_as_text())
	access.close()
	
	access = FileAccess.open("res://text/" + selected_language + "/extra_item.json", FileAccess.READ)
	extra_item = JSON.parse_string(access.get_as_text())
	access.close()
	
	access = FileAccess.open("res://text/" + selected_language + "/health_item.json", FileAccess.READ)
	health_item = JSON.parse_string(access.get_as_text())
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
	
	# Random Dialog
	access = FileAccess.open("res://text/" + selected_language + "/intro_dialog.json", FileAccess.READ)
	dialog = JSON.parse_string(access.get_as_text())
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
	access = FileAccess.open("res://text/" + selected_language + "/Stage1_C3_fail.json", FileAccess.READ)
	Stage1_C3_fail = JSON.parse_string(access.get_as_text())
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
	access = FileAccess.open("res://text/" + selected_language + "/Stage1_C_end.json", FileAccess.READ)
	Stage1_C_end = JSON.parse_string(access.get_as_text())
	access.close()
	
	# notice
	access = FileAccess.open("res://text/" + selected_language + "/notice.json", FileAccess.READ)
	notice = JSON.parse_string(access.get_as_text())
	access.close()
	
	# Stage 2
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_End.json", FileAccess.READ)
	Stage2_end = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_failure.json", FileAccess.READ)
	Stage2_failure = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_H1.json", FileAccess.READ)
	Stage2_H1 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_H2.json", FileAccess.READ)
	Stage2_H2 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_L.json", FileAccess.READ)
	Stage2_L = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_R1.json", FileAccess.READ)
	Stage2_R1 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_R2.json", FileAccess.READ)
	Stage2_R2 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_S1.json", FileAccess.READ)
	Stage2_S1 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_S2.json", FileAccess.READ)
	Stage2_S2 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_T1.json", FileAccess.READ)
	Stage2_T1 = JSON.parse_string(access.get_as_text())
	access.close()
	access = FileAccess.open("res://text/" + selected_language + "/Stage2_T2.json", FileAccess.READ)
	Stage2_T2 = JSON.parse_string(access.get_as_text())
	access.close()

func reset_cart():
	current_cart.assign(cart_reset)
	food.assign(food_reset)
	drink.assign(drink_reset)
	health.assign(health_reset)
	extra.assign(extra_reset)
	posts_register.assign(posts_reset)
