extends TextureRect

func _ready() -> void:
	texture.noise.seed = randi_range(-500, 500)
