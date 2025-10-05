extends Control

# Main Menu buttons
@onready var buttons: VBoxContainer = $Buttons
@onready var start_game: Button = $Buttons/StartGame
@onready var options: Button = $Buttons/Options
@onready var credits: Button = $Buttons/Credits
@onready var quit_game: Button = $Buttons/QuitGame

# Options Buttons
@onready var options_panel: Panel = $Options
@onready var back: Button = $Options/Back
@onready var sfx_control: HSlider = $Options/VBoxContainer/SFXControl
@onready var music_control: HSlider = $Options/VBoxContainer/MusicControl
@onready var fullscreen_toggle: CheckButton = $Options/VBoxContainer/FullscreenToggle

# Music Mixers
var sfx_bus : int
var mus_bus : int

func _ready() -> void:
	# Hide options panel
	options_panel.visible = false
	
	# Get audio save
	sfx_control.value = db_to_linear(DEF.settings_save["sfx_volume"])
	music_control.value = db_to_linear(DEF.settings_save["mus_volume"])
	
	
	# Get fullscreen save
	if DEF.settings_save["fullscreen"]:
		fullscreen_toggle.button_pressed = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		fullscreen_toggle.button_pressed = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	# Get buses
	sfx_bus = AudioServer.get_bus_index("SFX")
	mus_bus = AudioServer.get_bus_index("Music")
	
	AudioServer.set_bus_volume_db(sfx_bus, DEF.settings_save["sfx_volume"])
	AudioServer.set_bus_volume_db(mus_bus, DEF.settings_save["mus_volume"])
	
	AUDIO.play_music("menu_theme")

func _on_start_game_pressed() -> void:
	AUDIO.play_sfx("click")
	SCENE.load_scene("testing")
	

func _on_options_pressed() -> void:
	options_panel.visible = true
	buttons.visible = false
	AUDIO.play_sfx("click")

func _on_credits_pressed() -> void:
	SCENE.load_scene("credits")
	AUDIO.play_sfx("click")

func _on_quit_game_pressed() -> void:
	AUDIO.play_sfx("click", true)
	get_tree().quit()

func _on_back_pressed() -> void:
	buttons.visible = true
	options_panel.visible = false
	AUDIO.play_sfx("click")
	save_settings()

func save_settings() -> void:
	var access = FileAccess.open(DEF.CONFIG_PATH, FileAccess.WRITE)
	access.store_string(JSON.stringify(DEF.settings_save))
	access.close()

func _on_sfx_control_value_changed(value: float) -> void:
	value = linear_to_db(value)
	AudioServer.set_bus_volume_db(sfx_bus, value)
	DEF.settings_save["sfx_volume"] = value

func _on_music_control_value_changed(value: float) -> void:
	value = linear_to_db(value)
	AudioServer.set_bus_volume_db(mus_bus, value)
	DEF.settings_save["mus_volume"] = value

func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	DEF.settings_save["fullscreen"] = toggled_on
