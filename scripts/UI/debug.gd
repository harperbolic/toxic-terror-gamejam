extends Panel

@onready var scene_selector: MenuButton = $Container/SceneSelector
@onready var popup = scene_selector.get_popup()

func _ready() -> void:
	add_scenes()
	popup.id_pressed.connect(change_scene)

func add_scenes():
	for r in SCENE.scenes:
		popup.add_item(r)

func change_scene(id):
	var scene_str : String = popup.get_item_text(id)
	SCENE.load_scene(scene_str)

func _on_button_pressed() -> void:
	DEF.selected_language = "debug"
	DEF.load_locale()
