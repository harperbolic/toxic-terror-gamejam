extends Node

const NOTIFICATION = preload("uid://ca36nbs67txvt")

func show_notification(type : String) -> void:
	AUDIO.play_sfx("click_refuse")
	
	var instance = NOTIFICATION.instantiate()
	add_child(instance)
	
	var label_text : String
	
	match type:
		"order":
			label_text = DEF.UI_text.get("order")
		"post":
			label_text = DEF.UI_text.get("post")
		"item":
			label_text = DEF.UI_text.get("item")
	
	instance.change_label_text(label_text)
	
	await get_tree().create_timer(2.0).timeout
	instance.queue_free()
