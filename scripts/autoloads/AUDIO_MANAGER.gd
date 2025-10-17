extends Node

func play_sfx(id : String, wait : bool = false) -> void:
	var node = get_node("%SFX/" + id)
	node.play()
	if wait:
		while node.is_playing():
			pass

func play_music(id : String) -> void:
	var node = get_node("%Music/" + id)
	node.play()

func stop_music(id : String) -> void:
	var node = get_node("%Music/" + id)
	node.stop()
