extends Node

var resolutions = {
	"3840 x 2160" : Vector2i(3840, 2160),
	"2560 x 1440" : Vector2i(2560, 1440),
	"1920 x 1080" : Vector2i(1920, 1080),
	"1440 x 900" : Vector2i(1440, 900),
	"1366 x 768" : Vector2i(1366, 768),
	"1280 x 720" : Vector2i(1280, 720)
}

var language = {
	"English" : 0,
	"Português" : 1
}

var settings_save = {
	"sfx_volume" : 0,
	"mus_volume" : 0,
	"fullscreen" : true,
	"resolution" : "1920 x 1080",
	"language" : "English"
}

func _ready() -> void:
	print ("Definitions Loaded")
