extends Node

signal sfx_finished

func play_sfx(id : String) -> void:
	var node = get_node("%SFX/" + id)
	node.play()

func play_music(id : String) -> void:
	var node = get_node("%Music/" + id)
	node.play()

func stop_music(id : String) -> void:
	var node = get_node("%Music/" + id)
	node.stop()

func stop_all_music() -> void:
	var root_node = get_node("%Music")
	var audio_node
	for child in root_node.get_children():
		audio_node = child
		audio_node.stop()

func _on_phone_ring_finished() -> void:
	sfx_finished.emit()

func _on_click_finished() -> void:
	sfx_finished.emit()


func _on_client_ring_finished() -> void:
	sfx_finished.emit()
