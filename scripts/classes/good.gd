extends Sprite2D

class_name good

@onready var rigid_body_2d: RigidBody2D = $RigidBody2D

const FALL_SPEED = 1000
var fall_speed = FALL_SPEED
var accel = 1

var dragging = false
var of = Vector2(0,0)

func _physics_process(delta: float) -> void:
	if !dragging:
		position.y += fall_speed * delta * accel
		accel = accel * 1.05
	else:
		position = get_global_mouse_position() - of
	
	if rigid_body_2d.emit_signal("collided"):
		accel = 1
		fall_speed = 0

func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false
