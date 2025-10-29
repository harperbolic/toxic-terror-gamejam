extends PointLight2D

func _ready() -> void:
	while(true):
		await get_tree().create_timer(0.1).timeout
		energy = 1.125
		await get_tree().create_timer(0.1).timeout
		energy = 1.0
