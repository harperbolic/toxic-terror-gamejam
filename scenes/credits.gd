extends Control
@onready var score : Label = $ColorRect/thanks2/balance
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	AUDIO.stop_all_music()
	score.text += str(DEF.save.get("balance"))
	AUDIO.play_music("credits")
	animation_player.play("roll_credits")
	await animation_player.animation_finished
	SCENE.load_scene("main_menu")
