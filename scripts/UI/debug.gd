extends Panel

@onready var scene_selector: MenuButton = $Container/SceneSelector

func _ready() -> void:
	add_scenes()

func add_scenes():
	for r in SCENE.scenes:
		scene_selector.get_popup().add_item(r)

#func _input(_event: InputEvent) -> void:
#	if Input.is_action_just_pressed("mouse_left"):
#		scene_id = scene_selector.get_popup().get_current_index()
		
