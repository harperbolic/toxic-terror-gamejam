extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_client : Node
var client

const MILK = preload("res://scenes/goods/milk.tscn")
const MIOJO = preload("res://scenes/goods/miojo.tscn")
const ENERGY = preload("res://scenes/goods/energy.tscn")
const BEER = preload("res://scenes/goods/beer.tscn")
const CHOCOLATE = preload("res://scenes/goods/chocolate.tscn")

@onready var end: Button = $ActionButton/End/button
@onready var talk: Button = $ActionButton/Talk/button
@onready var report: Button = $ActionButton/Report/button

@onready var day_letter: Label = $Title/DayLabel
@onready var goods = $Goods

signal client_served
signal right_order
signal wrong_order

func _ready() -> void:
	
	# localization
	# Action
	end.text = DEF.UI_text.get("end_order")
	talk.text = DEF.UI_text.get("talk")
	report.text = DEF.UI_text.get("report")
	
	AUDIO.stop_all_music()
	AUDIO.play_music("shift_theme")
	
	day_letter.text = DEF.UI_text.get("day") + " " + str(int(DEF.save.get("level")))
	
	
	
	# AUDIO.play_sfx("bell")
	animation_player.play("fade_title")
	await animation_player.animation_finished
	
	AUDIO.play_sfx("shift_start")
	
	await get_tree().create_timer(1.0).timeout
	
	animation_player.play("fade")
	await animation_player.animation_finished
	
	DIALOG.start_dialog(DEF.Stage1_C1)
	await DIALOG.dialog_ended
	
	await get_tree().create_timer(0.8).timeout
	new_client()
	await get_tree().create_timer(0.8).timeout
	
	DIALOG.start_dialog(DEF.Stage1_C2)
	await DIALOG.dialog_ended	
	spawn_items()
	
	await client_served
	
	DIALOG.start_dialog(DEF.Stage1_C3)
	await DIALOG.dialog_ended
	
	client_exit()
	
	await get_tree().create_timer(1.5).timeout
	
	new_client("H")
	await get_tree().create_timer(0.8).timeout
	
	DIALOG.start_dialog(DEF.Stage1_H1)
	await DIALOG.dialog_ended

func new_client(ClientID = null) -> void:	
	if ClientID != null:
		current_client = get_node("Clients/" + ClientID)
	else:
		current_client = get_node("Clients/random")
		client = CHAR.gen_char()
	
	current_client.visible = true
	AUDIO.play_sfx("client_ring")
	animation_player.play("client_enter")
	
	DEF.current_cart.assign(DEF.cart_reset)

func client_exit() -> void:
	if current_client != null:
		animation_player.play("client_exit")
		await animation_player.animation_finished
		current_client.visible = false
	else:
		return

func spawn_items() -> void:
	var position = Vector2(700, 800)
	var x = client.item.get("miojo")
	while x != 0:
		position.x += 100
		var object = MIOJO.instantiate()
		object.position = position
		goods.add_child(object)
		x -= 1
	
	x = client.item.get("chocolate")
	while x != 0:
		position.x += 100
		var object = CHOCOLATE.instantiate()
		object.position = position
		goods.add_child(object)
		x -= 1
	
	x = client.item.get("beer")
	while x != 0:
		position.x += 100
		var object = BEER.instantiate()
		object.position = position
		goods.add_child(object)
		x -= 1
	
	x = client.item.get("milk")
	while x != 0:
		position.x += 100
		var object = MILK.instantiate()
		object.position = position
		goods.add_child(object)
		x -= 1
	
	x = client.item.get("energy")
	while x != 0:
		position.x += 100
		var object = ENERGY.instantiate()
		object.position = position
		goods.add_child(object)
		x -= 1

func end_order():
	for n in goods.get_children():
		n.queue_free()
	
	if DEF.current_cart == client.item:
		right_order.emit()
		print("right order")
	else:
		wrong_order.emit()
		print("wrong order")
	
	client_served.emit()

func _on_basket_body_entered(body: Node2D) -> void:
	body.add()


func _on_button_pressed() -> void:
	end_order()
