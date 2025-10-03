extends Panel

@onready var resolution_button: OptionButton = $AudioManager/VBoxContainer/OptionButton
@onready var fullscreen_box: CheckBox = $AudioManager/VBoxContainer/CheckBox

func _ready() -> void:
	add_resolutions()
	resolution_button.disabled = true
	
	# Load saved settinggs
	if DEF.settings_save["fullscreen"]:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		resolution_button.disabled = true
		fullscreen_box.toggle_mode = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		resolution_button.disabled = false
		fullscreen_box.toggle_mode = false
	
	update_button_value()

func add_resolutions():
	for r in DEF.resolutions:
		resolution_button.add_item(r)

# fulscreen checkbox
func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen_box.toggle_mode = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen_box.toggle_mode = false

# 
func update_button_value():
	var window_size_string = str(get_window().size.x, " x ", get_window().size.y)
	var resolutions_index = DEF.resolutions.keys().find(window_size_string)
	resolution_button.selected = resolutions_index

func _on_option_button_item_selected(index: int) -> void:
	var key = resolution_button.get_item_text(index)
	get_window().set_size(DEF.resolutions[key])
	center_window()

func center_window() -> void:
	var screen_center  = DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(screen_center - window_size / 2)
