extends Node

var SM : String = "Scene Manager: "

var scenes = {
	"main_menu" : "res://scenes/main_menu.tscn",
	"testing" : "res://scenes/testing.tscn",
	"stage0" : "res://scenes/stages/stage0.tscn",
	"stage1" : "res://scenes/stages/stage1.tscn",
	"stage1_L" : "res://scenes/stages/stage1_L.tscn",
	"stage2" : "res://scenes/stages/stage2.tscn",
	"stage3" : "res://scenes/stages/stage3.tscn",
	"stage4" : "res://scenes/stages/stage4.tscn",
	"stage5" : "res://scenes/stages/stage5.tscn",
	"stage6" : "res://scenes/stages/stage6.tscn",
	"credits" : "res://scenes/credits.tscn"
}

@onready var scene = load(scenes["main_menu"]).instantiate()
@onready var old_scene = scene

func _ready() -> void:
	print(SM, "Scene 'main_menu' loaded")
	add_child(scene)

func load_scene(scene_str : String) -> void:
	old_scene.queue_free()
	scene = load(scenes[scene_str]).instantiate()
	print(SM, "Scene '", scene_str, "' loaded.")
	add_child(scene)
	old_scene = scene
