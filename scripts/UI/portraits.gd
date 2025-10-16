extends Node

@onready var MC : Control = $MC
@onready var Cli : Control = $Cli
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var is_MC_on_screen = false
var is_Cli_on_screen = false
var current_cli = ""
var type

var emotion_list = [
	"null",
	"happy",
]

var character : String

func change_portrait (id : String, emotion : String):
	clear_portraits(id)
	
	if current_cli != id && id != "M":
		is_Cli_on_screen = false
	
	if id == "M":
		type = "MC"
		if !is_MC_on_screen:
			animation_player.play("mc_fade_in")
			is_MC_on_screen = true
	else:
		type = "Cli"
		if !is_Cli_on_screen:
			animation_player.play("cli_fade_in")
			is_Cli_on_screen = true
			current_cli = id
	
	var node = get_node(type + "/" + id + "_" + emotion)
	node.visible = true
	

func clear_portraits(id : String):
	if id == "M":
		for child in MC.get_children():
			child.visible = false
	else:
		for child in Cli.get_children():
			child.visible = false
