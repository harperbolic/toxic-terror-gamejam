extends Control

@onready var menu: Control = $Menu
@onready var food_button: Button = $Menu/Food/Button
@onready var drink_button: Button = $Menu/Drink/Button
@onready var health_button: Button = $Menu/Health/Button
@onready var extra_button: Button = $Menu/Extra/Button
@onready var waiting: Label = $Preparing/Control/Waiting

@onready var food: Control = $Menu/Food
@onready var drink: Control = $Menu/Drink
@onready var health: Control = $Menu/Health
@onready var extra: Control = $Menu/Extra

@onready var items: Control = $Items
@onready var food_menu: Control = $Items/Food
@onready var food_name: Label = $Items/Food/Name
@onready var food_description: Label = $Items/Food/Description

@onready var preparing: Control = $Preparing
@onready var timer: Timer = $Preparing/Timer

var selected_menu  : int = 0
var selected_item : int = 0
var current_menu : String
var max_item : int

signal item_done

func _ready() -> void:
	# localization
	# menu
	food_button.text = DEF.UI_text.get("food")
	drink_button.text = DEF.UI_text.get("drink")
	health_button.text = DEF.UI_text.get("health")
	extra_button.text = DEF.UI_text.get("extra")
	waiting.text = DEF.UI_text.get("waiting")
	
	menu.visible = true
	items.visible = false
	preparing.visible = false
	
	update_menu(selected_menu)

func _on_forward_pressed() -> void:
	if selected_menu >= 3:
		selected_menu = 0
	else:
		selected_menu += 1
	
	AUDIO.play_sfx("click_ui")
	update_menu(selected_menu)

func _on_back_pressed() -> void:
	if selected_menu <= 0:
		selected_menu = 3
	else:
		selected_menu -= 1
	
	AUDIO.play_sfx("click_ui")
	update_menu(selected_menu)

func update_menu(num : int) -> void:
	food.visible = false
	drink.visible = false
	health.visible = false
	extra.visible = false
	
	print(num)
	
	match num:
		0:
			food.visible = true
		1:
			drink.visible = true
		2:
			health.visible = true
		3:
			extra.visible = true

func _on_food_pressed() -> void:
	items.visible = true
	food_menu.visible = true
	current_menu = "food"
	AUDIO.play_sfx("click_confirm")
	get_dict_size()
	item_update()

func _on_drink_pressed() -> void:
	items.visible = true
	food_menu.visible = true
	current_menu = "drink"
	AUDIO.play_sfx("click_confirm")
	get_dict_size()
	item_update()

func _on_health_pressed() -> void:
	items.visible = true
	food_menu.visible = true
	current_menu = "extra"
	AUDIO.play_sfx("click_confirm")
	get_dict_size()
	item_update()

func _on_extra_pressed() -> void:
	items.visible = true
	food_menu.visible = true
	current_menu = "health"
	AUDIO.play_sfx("click_confirm")
	get_dict_size()
	item_update()

func _on_prepare_pressed() -> void:
	AUDIO.play_sfx("click_confirm")
	prepare_item()

func prepare_item():
	menu.visible = false
	items.visible = false
	preparing.visible = true
	
	timer.start()
	
	await item_done
	
	menu.visible = true
	items.visible = false
	preparing.visible = false
	
	selected_item = 0

func _on_exit_pressed() -> void:
	AUDIO.play_sfx("click_refuse")
	items.visible = false
	menu.visible = true
	selected_item = 0

func get_dict_size() -> void:
	match current_menu:
		"food":
			max_item = DEF.food_item.size()- 1
		"drink":
			max_item = DEF.drink_item.size() - 1
		"health":
			max_item = DEF.health_item.size()- 1
		"extra":
			max_item = DEF.extra_item.size()- 1

func _on_forward_item_pressed() -> void:
	AUDIO.play_sfx("click_ui")
	selected_item += 1
	
	if selected_item > max_item:
		selected_item = 0
	
	item_update()

func _on_back_item_pressed() -> void:
	AUDIO.play_sfx("click_ui")
	selected_item -= 1
	
	if selected_item < 0:
		selected_item = max_item
	
	item_update()

func item_update() -> void:
	match current_menu:
		"food":
			food_name.text = DEF.food_item[str(selected_item)].get("name")
			food_description.text = DEF.food_item.get(str(selected_item)).get("description")
		"drink":
			food_name.text = DEF.drink_item[str(selected_item)].get("name")
			food_description.text = DEF.drink_item.get(str(selected_item)).get("description")
		"health":
			food_name.text = DEF.health_item[str(selected_item)].get("name")
			food_description.text = DEF.health_item.get(str(selected_item)).get("description")
		"extra":
			food_name.text = DEF.extra_item[str(selected_item)].get("name")
			food_description.text = DEF.extra_item.get(str(selected_item)).get("description")


func _on_timer_timeout() -> void:
	match current_menu:
		"food":
			DEF.food[DEF.food_item.get(str(selected_item)).get("id")] += 1
			print (DEF.food)
		"drink":
			DEF.drink[DEF.drink_item.get(str(selected_item)).get("id")] += 1
			print (DEF.drink)
		"health":
			DEF.extra[DEF.health_item.get(str(selected_item)).get("id")] += 1
			print (DEF.extra)
		"extra":
			DEF.health[DEF.extra_item.get(str(selected_item)).get("id")] += 1
			print (DEF.health)
	
	item_done.emit()
	AUDIO.play_sfx("click_confirm")
