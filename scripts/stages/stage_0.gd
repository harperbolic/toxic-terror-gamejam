extends Node

func _ready() -> void:
	AUDIO.stop_all_music()
	
	await get_tree().create_timer(1.2).timeout
	AUDIO.play_sfx("phone_ring")
	await AUDIO.sfx_finished
	
	DIALOG.start_dialog(DEF.Stage0)
	
	await DIALOG.dialog_ended
	
	DEF.save["level"] = 1
	
	DEF.save_game()
	SCENE.load_scene("stage1")
	
