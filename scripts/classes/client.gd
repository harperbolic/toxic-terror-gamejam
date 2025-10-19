extends Node
class_name Client

var id : String
var order_list : Array[int]
var patiance = 100
var frustration = 0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	if patiance == 0:
		fail.emit()
