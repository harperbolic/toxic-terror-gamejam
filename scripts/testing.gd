extends Node

# UI ELEMENTS
@onready var delete_button: Button = $Cellphone/Posts/VBoxContainer/HBoxContainer/Delete
@onready var approve_button: Button = $Cellphone/Posts/VBoxContainer/HBoxContainer/Approve
@onready var report_button: Button = $Cellphone/Posts/VBoxContainer/Report

@onready var id: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Info/MarginContainer/VBoxContainer/ID/Name
@onready var id_2: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Info/MarginContainer/VBoxContainer/ID/Name2
@onready var age: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Info/MarginContainer/VBoxContainer/Age/Age
@onready var age_2: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Info/MarginContainer/VBoxContainer/Age/Age2
@onready var sex: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Info/MarginContainer/VBoxContainer/Sex/Sex
@onready var sex_2: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Info/MarginContainer/VBoxContainer/Sex/Sex2

@onready var mood: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Label
@onready var neutral: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Neutral
@onready var depressed: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Depressed
@onready var nervous: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Nervous
@onready var mad: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Mad
@onready var inconclusive: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Mood/MarginContainer2/Mood/HBoxContainer/Moods/Inconclusive

@onready var illness: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Status/MarginContainer3/Status/Illness/Illness
@onready var illness_2: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Status/MarginContainer3/Status/Illness/MarginContainer/Illness2
@onready var criminal_record: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Status/MarginContainer3/Status/CriminalRecord/CriminalRecord
@onready var criminal_record_2: Label = $Cellphone/Overview/HBoxContainer/Control/MarginContainer/VBoxContainer/Status/MarginContainer3/Status/CriminalRecord/MarginContainer2/CriminalRecord2

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var cellphone_active : bool = false

func _ready() -> void:
	# locale settings
	delete_button.text = DEF.UI_text.get("delete_button")
	approve_button.text = DEF.UI_text.get("approve_button")
	report_button.text = DEF.UI_text.get("report_button")
	id.text = DEF.UI_text.get("id")
	age.text = DEF.UI_text.get("age")
	sex.text = DEF.UI_text.get("sex")
	mood.text = DEF.UI_text.get("mood")
	illness.text = DEF.UI_text.get("illness")
	neutral.text = DEF.UI_text.get("neutral")
	depressed.text = DEF.UI_text.get("depressed")
	nervous.text = DEF.UI_text.get("nervous")
	mad.text = DEF.UI_text.get("mad")
	inconclusive.text = DEF.UI_text.get("inconclusive")
	criminal_record.text = DEF.UI_text.get("record")
	
	print (CHAR.gen_char())

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("tab"):
		if cellphone_active:
			animation_player.play("cellphone")
		else:
			animation_player.play_backwards("cellphone")
		
		cellphone_active = !cellphone_active
