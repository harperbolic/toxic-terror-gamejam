extends Control

@onready var title: Label = $Title
@onready var description: Label = $Description
@onready var description_2: Label = $Description2

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title.text = DEF.notice.get("title")
	description.text = DEF.notice.get("day2")
	description_2.text = DEF.notice.get("disclaimer")

func _on_exit_pressed() -> void:
	start_game.emit()
	queue_free()
