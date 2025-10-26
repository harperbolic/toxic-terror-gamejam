extends CharacterBody2D

class_name good

const FALL_SPEED = 100
var fall_speed = FALL_SPEED

@export var sound_id : int
@export var item_key : String

var dragging = false
var movable = true
var of = Vector2(0,0)

func _physics_process(delta: float) -> void:
	if !dragging && !is_on_floor():
		velocity += fall_speed * get_gravity() * delta
	elif dragging and movable:
		position = get_global_mouse_position() - of
		velocity = Vector2(0, 0)
	
	
	move_and_slide()

func _on_button_button_down() -> void:
	if movable:
		dragging = true
		of = get_global_mouse_position() - global_position
		match sound_id:
			0:
				AUDIO.play_sfx("bottle_pick")
			1:
				AUDIO.play_sfx("box_pick")
			2:
				AUDIO.play_sfx("bag_pick")

func _on_button_button_up() -> void:
	if movable:
		dragging = false
		match sound_id:
			0:
				AUDIO.play_sfx("bottle_drop")
			1:
				AUDIO.play_sfx("box_drop")
			2:
				AUDIO.play_sfx("bag_drop")

func add() -> void:
	movable = false
	DEF.current_cart[item_key] += 1
