extends Control

@onready var posts: VBoxContainer = $Posts
@onready var overview: Control = $Overview
@onready var username: Label = $Posts/HBoxContainer/VBoxContainer/MarginContainer/username
@onready var tweet: Label = $Posts/HBoxContainer/VBoxContainer/tweet
@onready var delete_button: Button = $Posts/HBoxContainer2/Delete/Button
@onready var approve_button: Button = $Posts/HBoxContainer2/Approve/Button

#overview
@onready var username2: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Info/MarginContainer/VBoxContainer/ID/Name2
@onready var age: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Info/MarginContainer/VBoxContainer/Age/Age2
@onready var sex: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Info/MarginContainer/VBoxContainer/Sex/Sex2
@onready var illness: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Status/MarginContainer3/Status/Illness/MarginContainer/Illness2
@onready var record: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Status/MarginContainer3/Status/CriminalRecord/MarginContainer2/CriminalRecord2


# moods
@onready var neutral: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Neutral
@onready var depressed: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Depressed
@onready var nervous: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Nervous
@onready var mad: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Mad
@onready var inconclusive: Label = $Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Inconclusive


var counter = 1
var post_max = 3

var client : Dictionary

func update_all(client_func : Dictionary):
	print(client_func)
	client.assign(client_func)
	posts.visible = true
	overview.visible=  false
	delete_button.text = DEF.UI_text["delete_button"]
	approve_button.text = DEF.UI_text["approve_button"]
	
	username.text = client.get("username")
	username2.text = client.get("username")
	age.text = str(client.get("age"))
	sex.text = client.get("sex")
	
	if client["illness"]:
		illness.text = client.get("illness")
	else:
		record.text = DEF.UI_text.get("not_found")
	
	if client["record"]:
		record.text = client.get("record")
	else:
		record.text = DEF.UI_text.get("not_found")
	
	neutral.text = DEF.UI_text.get("neutral")
	depressed.text = DEF.UI_text.get("depressed")
	nervous.text = DEF.UI_text.get("nervous")
	mad.text = DEF.UI_text.get("mad")
	inconclusive.text = DEF.UI_text.get("inconclusive")
	
	neutral.visible = false
	depressed.visible = false
	nervous.visible = false
	mad.visible = false
	inconclusive.visible = false
	
	match client.get("mood"):
		"neutral":
			neutral.visible = true
		"depressed":
			depressed.visible = true
		"nervous":
			nervous.visible = true
		"mad":
			mad.visible = true
		"inconclusive":
			inconclusive.visible = true
	
	next_post(counter)

func next_post(post : int):
	match post:
		1:
			tweet.text = client["post1"]["text"]
		2:
			tweet.text = client["post2"]["text"]
		3:
			tweet.text = client["post3"]["text"]
		4:
			display_overview()

func display_overview():
	counter = 1
	posts.visible = false
	overview.visible = true

func _on_delete_pressed() -> void:
	match counter:
		1:
			DEF.posts_register["post1"] = true
			print("Selected1: " + str(DEF.posts_register["post1"]))
		2:
			DEF.posts_register["post2"] = true
			print("Selected2: " + str(DEF.posts_register["post2"]))
		3:
			DEF.posts_register["post3"] = true
			print("Selected3: " + str(DEF.posts_register["post3"]))
	counter += 1
	next_post(counter)

func _on_approve_pressed() -> void:
	match counter:
		1:
			DEF.posts_register["post1"] = false
			print("Selected1: " + str(DEF.posts_register["post1"]))
		2:
			DEF.posts_register["post2"] = false
			print("Selected2: " + str(DEF.posts_register["post2"]))
		3:
			DEF.posts_register["post3"] = false
			print("Selected3: " + str(DEF.posts_register["post3"]))
	counter += 1
	next_post(counter)
