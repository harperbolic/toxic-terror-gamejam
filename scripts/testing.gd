extends Node

var lines : Dictionary = {
	000 : {"name" : "L", "expression" : "angry", "text" : "Hey babe! Where are you?"},
	001 : {"name" : "M", "expression" : "none", "text" : "Just got here"},
	002 : {"name" : "M", "expression" : "angry", "text" : "How are you, love?"},
	003 : {"name" : "L", "expression" : "none", "text" : "Welcome home! I’ve been waiting for you all day!"},
	004 : {"name" : "M", "expression" : "none", "text" : "So sorry, you know how busy I am."},
	005 : {"name" : "L", "expression" : "none", "text" : "I know, I know, you’re my favorite hard worker."},
	006 : {"name" : "L", "expression" : "none", "text" : "Which reminds me, there's something important I needed to talk to you about."},	
	007 : {"name" : "M", "expression" : "none", "text" : "Did something happen?"},
	008 : {"name" : "L", "expression" : "none", "text" : "Come on, let me talk."},
	009 : {"name" : "L", "expression" : "none", "text" : "Do you remember when I was talking about that chaotic situation at home, with my parents?"},
	010 : {"name" : "L", "expression" : "none", "text" : "With that, we decided to move out."},
	011 : {"name" : "M", "expression" : "none", "text" : "Move out?"},
}

func _on_button_pressed() -> void:
	DIALOG.start_dialog(lines)
