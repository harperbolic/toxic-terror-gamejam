extends VBoxContainer

@onready var label: Label = $Label

func _ready() -> void:
	label.text = DEF.UI_text.get("press_space")
