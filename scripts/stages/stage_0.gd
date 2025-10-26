extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $DayLetter/Label

func _ready() -> void:
	AUDIO.stop_all_music()
	
	await get_tree().create_timer(1.2).timeout
	AUDIO.play_sfx("phone_ring")
	await AUDIO.sfx_finished
	
	DIALOG.start_dialog(DEF.Stage0)
	
	await DIALOG.dialog_ended
	
	DEF.save["level"] = 1
	var day_number : int = DEF.save["level"]
	label.text = DEF.UI_text.get("day") + " " + str(day_number)
	
	AUDIO.play_sfx("bell")
	animation_player.play("day_letter")
	await animation_player.animation_finished
	
	await get_tree().create_timer(3.0).timeout
	
	animation_player.play_backwards("day_letter")
	await animation_player.animation_finished
	
	DEF.save_game()
	SCENE.load_scene("stage1")
	
