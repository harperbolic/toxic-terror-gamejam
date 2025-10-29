extends Node

@export var has_label : bool = false

@onready var color_poly: Polygon2D = $Polygon2D2
@onready var black_poly: Polygon2D = $Polygon2D

@export var change_color = false
var modulate_color = 0

var frame : int 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if frame > 10:
		change_poly()
		frame = 0
	frame += 1
	
	if change_color:
		modulate_color += 0.01
		if modulate_color > 1.0:
			modulate_color = 0
		color_poly.color = Color.from_hsv(modulate_color, 1.0, 0.77, 1.0)

func change_poly():
	var number = randf_range(-0.025, 0.025)
	color_poly.skew = number
	number = randf_range(-0.012, 0.012)
	black_poly.skew = number

func change_label_text(text : String):
	if has_label:
		var label: Label = $Label
		label.text = text
