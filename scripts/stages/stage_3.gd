extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_client : Node
var client : Dictionary
var removed_posts
var H : Dictionary
var T : Dictionary
var S : Dictionary
var B : Dictionary
var R : Dictionary

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

@onready var cellphone: Control = $Cellphone

signal client_served
var is_order_right

func _ready() -> void:
	
	# localization
	# Action
	end.text = DEF.UI_text.get("end_order")
	talk.text = DEF.UI_text.get("talk")
	report.text = DEF.UI_text.get("report")
	
	# Create canon characters
	H.assign(CHAR.H)
	H.dialog.assign(DEF.Stage2_H1)
	H.order = {
		"drinks" : {"Orange": 0, "Maracuja": 0, "HotChocolate": 0, "BlackCoffee": 0, "Cappuccino": 0, "Afogatto": 0, "Espresso": 0, "Pingado": 0},
		"foods" : {"HotLunch": 1, "Tostex": 0, "Katsu": 0, "Bauru": 0, "Choripan": 0, "Sausage": 0, "Ham": 0, "Director": 0},
		"meds" : {"SleepingPills": 0, "Condom": 0, "Syrup": 0, "Razor": 0},
		"extra" : {"Camera": 0, "Cigarette": 0, "Gummy": 0}
	}
	
	S.assign(CHAR.S)
	S.dialog.assign(DEF.Stage3_T2)
	S.item = {"miojo": 0, "chocolate": 0, "beer": 0, "milk": 0, "energy": 0}
	S.order = {
		"drinks" : {"Orange": 0, "Maracuja": 0, "HotChocolate": 0, "BlackCoffee": 0, "Cappuccino": 0, "Afogatto": 0, "Espresso": 0, "Pingado": 0},
		"foods" : {"HotLunch": 0, "Tostex": 0, "Katsu": 0, "Bauru": 0, "Choripan": 0, "Sausage": 0, "Ham": 0, "Director": 0},
		"meds" : {"SleepingPills": 0, "Condom": 0, "Syrup": 0, "Razor": 0},
		"extra" : {"Camera": 0, "Cigarette": 0, "Gummy": 0}
	}
	S.post1 = CHAR.gen_post()
	S.post2 = CHAR.gen_post()
	S.post3 = CHAR.gen_post()
	
	B.assign(CHAR.B)
	B.dialog.assign(DEF.Stage3_B1)
	B.item = {"miojo": 0, "chocolate": 0, "beer": 0, "milk": 0, "energy": 0}
	B.order = {
		"drinks" : {"Orange": 0, "Maracuja": 0, "HotChocolate": 0, "BlackCoffee": 0, "Cappuccino": 0, "Afogatto": 0, "Espresso": 0, "Pingado": 0},
		"foods" : {"HotLunch": 0, "Tostex": 0, "Katsu": 0, "Bauru": 0, "Choripan": 0, "Sausage": 0, "Ham": 0, "Director": 0},
		"meds" : {"SleepingPills": 0, "Condom": 0, "Syrup": 0, "Razor": 0},
		"extra" : {"Camera": 0, "Cigarette": 1, "Gummy": 0}
	}
	B.post1 = CHAR.gen_post()
	B.post2 = CHAR.gen_post()
	B.post3 = CHAR.gen_post()
	
	T.assign(CHAR.T)
	T.dialog.assign(DEF.Stage3_T2)
	T.item = {"miojo": 0, "chocolate": 0, "beer": 0, "milk": 1, "energy": 0}
	T.order = {
		"drinks" : {"Orange": 0, "Maracuja": 0, "HotChocolate": 0, "BlackCoffee": 0, "Cappuccino": 0, "Afogatto": 0, "Espresso": 0, "Pingado": 0},
		"foods" : {"HotLunch": 0, "Tostex": 0, "Katsu": 0, "Bauru": 0, "Choripan": 0, "Sausage": 0, "Ham": 0, "Director": 0},
		"meds" : {"SleepingPills": 0, "Condom": 0, "Syrup": 0, "Razor": 0},
		"extra" : {"Camera": 0, "Cigarette": 0, "Gummy": 0}
	}
	T.post1 = CHAR.gen_post()
	T.post2 = CHAR.gen_post()
	T.post3 = CHAR.gen_post()
	
	R.assign(CHAR.R)
	R.dialog.assign(DEF.Stage2_R1)
	R.item = {"miojo": 0, "chocolate": 0, "beer": 0, "milk": 0, "energy": 0}
	R.order = {
		"drinks" : {"Orange": 0, "Maracuja": 0, "HotChocolate": 0, "BlackCoffee": 0, "Cappuccino": 0, "Afogatto": 1, "Espresso": 0, "Pingado": 0},
		"foods" : {"HotLunch": 0, "Tostex": 0, "Katsu": 0, "Bauru": 0, "Choripan": 0, "Sausage": 0, "Ham": 0, "Director": 0},
		"meds" : {"SleepingPills": 0, "Condom": 0, "Syrup": 0, "Razor": 0},
		"extra" : {"Camera": 0, "Cigarette": 0, "Gummy": 0}
	}
	R.post1 = CHAR.gen_post()
	R.post2 = CHAR.gen_post()
	R.post3 = CHAR.gen_post()
	
	AUDIO.stop_all_music()
	AUDIO.play_music("shift_theme")
	
	day_letter.text = DEF.UI_text.get("day") + " " + str(int(DEF.save.get("level")))
	
	# AUDIO.play_sfx("bell")
	animation_player.play("fade_title")
	await animation_player.animation_finished
	$Title.visible = false
	
	AUDIO.play_sfx("shift_start")
	
	await get_tree().create_timer(0.8).timeout
	new_client()
	await get_tree().create_timer(0.8).timeout
	await client_served
	
	await get_tree().create_timer(0.8).timeout
	new_client("T")
	await get_tree().create_timer(0.8).timeout
	
	DIALOG.start_dialog(DEF.Stage3_T1)
	await DIALOG.dialog_ended
	await client_served
	DIALOG.start_dialog(DEF.Stage3_T3)
	await DIALOG.dialog_ended
	
	await get_tree().create_timer(0.8).timeout
	new_client()
	await get_tree().create_timer(0.8).timeout
	await client_served
	
	await get_tree().create_timer(0.8).timeout
	new_client()
	await get_tree().create_timer(0.8).timeout
	await client_served
	
	await get_tree().create_timer(0.8).timeout
	new_client("B")
	await get_tree().create_timer(0.8).timeout
	await client_served
	DIALOG.start_dialog(DEF.Stage3_B2)
	await DIALOG.dialog_ended
	
	await get_tree().create_timer(2.0).timeout
	
	DEF.save["level"] = 4
	DEF.save_game()
	SCENE.load_scene("stage4")

func new_client(ClientID = null) -> void:	
	DEF.reset_cart()
	
	if ClientID != null:
		current_client = get_node("Clients/" + ClientID)
		if ClientID == "H":
			client = H
		elif ClientID == "T":
			client = T
		elif ClientID == "S":
			client = S
		elif ClientID == "R":
			client = R
		elif ClientID == "H":
			client = H
		elif ClientID == "B":
			client = B
		else:
			print("ERROR: Invalid client id")
			return
		$Clients/random.visible = false
	else:
		current_client = get_node("Clients/random")
		client = CHAR.gen_char()
	print ("clientID: " + str(ClientID))
	
	current_client.visible = true
	AUDIO.play_sfx("client_ring")
	if ClientID != "H":
		animation_player.play("client_enter")
	else:
		animation_player.play("client_enter_H")
	
	spawn_items()

	await client_served

	client_exit()

func client_exit():
	animation_player.play("client_exit")
	await animation_player.animation_finished
	current_client.visible = false

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
	var is_posts_right
	
	print(DEF.posts_register)
	if client != H:
		print(client.post1.get("status"))
		print(client.post2.get("status"))
		print(client.post3.get("status"))
	else:
		is_posts_right  = true
	
	for n in goods.get_children():
		n.queue_free()
	
	if DEF.current_cart == client.item and DEF.drink == client.order.drinks and DEF.food == client.order.foods and DEF.health == client.order.meds and DEF.extra == client.order.extra :
		is_order_right = true
		print("right order")
	else:
		is_order_right = false
		print("wrong order")
		#print(client)
		#print(DEF.current_cart)
		#print(DEF.drink)
		#rint(DEF.food)
		#print(DEF.health)
		#print(DEF.extra)
		
		if client == H:
			is_posts_right = true
		elif DEF.posts_register.get("post1") == client["post1"].get("status") and DEF.posts_register.get("post2") == client["post2"].get("status") and DEF.posts_register.get("post3") == client["post3"].get("status"):
			is_posts_right = true
		else:
			is_posts_right = false
	
	if is_posts_right == false:
		print("Wrong posts")
		print ("Post 1 : " + str(DEF.posts_register.get("post1")) + " " + str(client["post1"].get("status")))
		print ("Post 2 : " + str(DEF.posts_register.get("post2")) + " " + str(client["post2"].get("status")))
		print ("Post 3 : " + str(DEF.posts_register.get("post3")) + " " + str(client["post3"].get("status")))
	
	if is_posts_right == false and is_order_right == false:
		NOT.show_notification("both")
	elif is_order_right == false:
		NOT.show_notification("order")
	elif is_posts_right == false:
		NOT.show_notification("post")
	
	var money = 20
	DEF.save["balance"] += money
	
	client_served.emit()

func _on_basket_body_entered(body: Node2D) -> void:
	body.add()

func _on_button_pressed() -> void:
	end_order()
	AUDIO.play_sfx("click")


func _on_talk_pressed() -> void:
	DIALOG.start_dialog(client.dialog)
	AUDIO.play_sfx("click")

func _on_cellphone_exit_pressed() -> void:
	animation_player.play("cellphone")
	AUDIO.play_sfx("click")

func _on_report_pressed() -> void:
	animation_player.play_backwards("cellphone")
	AUDIO.play_sfx("click")
	cellphone.update_all(client)
