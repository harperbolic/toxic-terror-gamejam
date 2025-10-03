extends Node

var SM : String = "Scene Manager: "

var scenes = {
	"main_menu" : "res://scenes/main_menu.tscn",
	"testing" : "res://scenes/testing.tscn"
}

@onready var scene = load(scenes["main_menu"]).instantiate()

func _ready() -> void:
	print()
	add_child(scene)

#func load_scene(scene_str : String) -> void:
#	var old_scene = scene
#	scene = scenes[scene_str].instantiate()
#	print(SM, "Scene '", scene_str, "' loaded.")
#	
#	add_child(scene)
#	
#		old_scene.free()
