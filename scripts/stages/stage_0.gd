extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $DayLetter/Label

func _ready() -> void:
	
	DEF.save = DEF.game_boilerplate
	
	await get_tree().create_timer(1.2).timeout
	AUDIO.play_sfx("phone_ring")
	await get_tree().create_timer(8.19).timeout
	
	DIALOG.start_dialog(DEF.Stage0)
	
	await DIALOG.dialog_ended
	
	AUDIO.play_sfx("bell")
	animation_player.play("day_letter")
	
	await animation_player.animation_finished
	
	SCENE.load_scene("Stage1")
	
	await get_tree().create_timer(3.0).timeout
