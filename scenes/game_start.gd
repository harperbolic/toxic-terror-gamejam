extends Node2D

func _ready() -> void:
	var debug_scene = load(SCENE.scenes["testing"]).instantiate()
	add_child(debug_scene)
