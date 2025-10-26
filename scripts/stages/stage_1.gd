extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_client : Node
var client

const MILK = preload("res://scenes/goods/milk.tscn")
const MIOJO = preload("res://scenes/goods/miojo.tscn")
const ENERGY = preload("res://scenes/goods/energy.tscn")
const BEER = preload("res://scenes/goods/beer.tscn")
const CHOCOLATE = preload("res://scenes/goods/chocolate.tscn")

@onready var goods = $Goods

signal client_served
signal right_order
signal wrong_order

func _ready() -> void:
	
	print(CHAR.gen_char())
	
	
	AUDIO.stop_all_music()
	AUDIO.play_music("shift_theme")
	AUDIO.play_sfx("shift_start")
	
	await get_tree().create_timer(1.0).timeout
	
	animation_player.play("fade")
	await animation_player.animation_finished
	await get_tree().create_timer(1.0).timeout
	
	DIALOG.start_dialog(DEF.Stage1_C1)
	await DIALOG.dialog_ended
	
	await get_tree().create_timer(0.8).timeout
	new_client()
	await get_tree().create_timer(0.8).timeout
	
	DIALOG.start_dialog(DEF.Stage1_C2)
	await DIALOG.dialog_ended
	
	spawn_items()
	
	await client_served

func new_client(ClientID = null) -> void:
	DEF.current_cart.assign(DEF.cart_reset)
	print(DEF.current_cart)
	
	if ClientID != null:
		current_client = get_node("Clients/" + ClientID)
	else:
		current_client = get_node("Clients/random")
		client = CHAR.gen_char()
	
	current_client.visible = true
	AUDIO.play_sfx("client_ring")
	animation_player.play("client_enter")
	
	DEF.current_cart.assign(DEF.cart_reset)
	print(DEF.current_cart)

func client_exit() -> void:
	if current_client != null:
		animation_player.play("client_exit")
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

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.add()
