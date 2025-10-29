extends Node

const NOTIFICATION = preload("uid://ca36nbs67txvt")

func show_notification(type : String) -> void:
	AUDIO.play_sfx("click_refuse")
	var value = 5
	
	var instance = NOTIFICATION.instantiate()
	add_child(instance)
	
	var label_text : String
	
	match type:
		"order":
			label_text = DEF.UI_text.get("order")
		"post":
			label_text = DEF.UI_text.get("post")
		"both":
			label_text = DEF.UI_text.get("both")
			value = 10
	
	instance.change_label_text(label_text)
	DEF.save["balance"] -= value
	
	await get_tree().create_timer(3.2).timeout
	instance.queue_free()
