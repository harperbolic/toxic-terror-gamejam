extends Control

@onready var buttons: VBoxContainer = $Buttons
@onready var options: Panel = $Options
@onready var option_button: OptionButton = $Options/AudioManager/VBoxContainer/OptionButton

func _on_start_game_pressed() -> void:
	SCENE.load_scene("testing")

func _on_options_pressed() -> void:
	options.visible = true
	buttons.visible = false

func _on_credits_pressed() -> void:
	pass # Replace with function body.

func _on_quit_game_pressed() -> void:
	await get_tree().create_timer(0.5).timeout
	print("Quitting game")
	get_tree().quit()

func _ready() -> void:
	# hide other menus
	options.visible = false
	buttons.visible = true
	
func scene_menu(id) -> void:
	match(id):
		0:
			get_tree().change_scene_to_file("res://scenes/testing.tscn")
		_:
			pass

func _on_back_pressed() -> void:
	options.visible = false
	buttons.visible = true
