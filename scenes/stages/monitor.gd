extends Control

@onready var food: Button = $MarginContainer/Menu/VBoxContainer/VBoxContainer2/HBoxContainer/Food
@onready var drinks: Button = $MarginContainer/Menu/VBoxContainer/VBoxContainer2/HBoxContainer/Drinks
@onready var health: Button = $MarginContainer/Menu/VBoxContainer/VBoxContainer2/HBoxContainer2/Health
@onready var extra: Button = $MarginContainer/Menu/VBoxContainer/VBoxContainer2/HBoxContainer2/Extra
@onready var instructions: Button = $MarginContainer/Menu/VBoxContainer/HBoxContainer2/Instructions
@onready var end: Button = $MarginContainer/Menu/VBoxContainer/HBoxContainer2/End

func _ready() -> void:
	food.text = DEF.UI_text.get("food")
	drinks.text = DEF.UI_text.get("drinks")
	health.text = DEF.UI_text.get("health")
	extra.text = DEF.UI_text.get("extra")
	instructions.text = DEF.UI_text.get("instructions")
	end.text = DEF.UI_text.get("end_order")
