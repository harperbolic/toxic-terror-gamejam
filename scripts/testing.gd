extends Node

# UI ELEMENTS
@onready var delete_button: Button = $Cellphone/Posts/VBoxContainer/HBoxContainer/Button
@onready var approve_button: Button = $Cellphone/Posts/VBoxContainer/HBoxContainer/Button2
@onready var report_button: Button = $Cellphone/Posts/VBoxContainer/Button3

func _on_button_pressed() -> void:
	DIALOG.start_dialog(DEF.Stage0)

func _ready() -> void:
	# locale settings
	delete_button.text = DEF.UI_text.get("delete_button")
	approve_button.text = DEF.UI_text.get("approve_button")
	report_button.text = DEF.UI_text.get("report_button")
