extends Control

@onready var color_poly: Polygon2D = $Polygon2D2
@onready var black_poly: Polygon2D = $Polygon2D

var frame : int 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if frame > 10:
		change_poly()
		frame = 0
	frame += 1

func change_poly():
	var number = randf_range(-0.1, 0.1)
	color_poly.skew = number
	number = randf_range(-0.01, 0.01)
	black_poly.skew = number
