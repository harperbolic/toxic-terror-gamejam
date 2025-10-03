extends CanvasLayer

const DEBUG_COMPONENT = "res://scenes/game_elements/debug.tscn"

func _ready():
	var debug_scene = preload(DEBUG_COMPONENT).instantiate()
	add_child(debug_scene)
	debug_scene.hide()

func _input(_event):
	if Input.is_action_just_pressed("debug"):
		var debug = get_node("Debug")
		debug.visible = !debug.visible
