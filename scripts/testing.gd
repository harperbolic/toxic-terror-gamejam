extends Node

var lines : Dictionary = {
	0 : "1st line",
	1 : "This is the second line"
}

var global_position : Vector2 = Vector2(200, 200)

func _on_button_pressed() -> void:
	DIALOG.start_dialog(global_position, lines)
