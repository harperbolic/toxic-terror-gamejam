extends Node

signal char_generated

var client_template : Dictionary = {
	"username" : "@template",
	"post1" : {
		"text" : "post1",
		"status" : false},
	"post2" : {
		"text" : "post2",
		"status" : false},
	"post3" : {
		"text" : "post3",
		"status" : false},
	"age" : 30,
	"sex" : "M",
	"mood" : "Mood",
	"illness" : "Illness",
	"record" : "Record",
	"item" : {"miojo": 0, "chocolate": 0, "beer": 0, "milk": 0, "energy": 0},
	"order" : {
		"drinks" : {"Orange": 0, "Maracuja": 0, "HotChocolate": 0, "BlackCoffee": 0, "Cappuccino": 0, "Afogatto": 0, "Espresso": 0, "Pingado": 0},
		"foods" : {"HotLunch": 0, "Tostex": 0, "Katsu": 0, "Bauru": 0, "Choripan": 0, "Sausage": 0, "Ham": 0, "Director": 0},
		"meds" : {"SleepingPills": 0, "Condom": 0, "Syrup": 0, "Razor": 0},
		"extra" : {"Camera": 0, "Cigarette": 0, "Gummy": 0}
	},
	"dialog" : {
		"0" : "Default dialog"
	}
}

var H : Dictionary = {
	"username" : "ERROR: Not found.",
	"post1" : null,
	"post2" : null,
	"post3" : null,
	"age" : "43",
	"sex" : "M",
	"mood" : "Normal",
	"illness" : "",
	"record" : "Driving under the influence",
	"item" : {"miojo": 0, "chocolate": 0, "beer": 0, "milk": 0, "energy": 0},
	"order" : {
		"drinks" : {"Orange": 1, "Maracuja": 0, "HotChocolate": 0, "BlackCoffee": 0, "Cappuccino": 0, "Afogatto": 0, "Espresso": 0, "Pingado": 0},
		"foods" : {"HotLunch": 1, "Tostex": 0, "Katsu": 0, "Bauru": 0, "Choripan": 0, "Sausage": 0, "Ham": 0, "Director": 0},
		"meds" : {"SleepingPills": 0, "Condom": 0, "Syrup": 0, "Razor": 0},
		"extra" : {"Camera": 0, "Cigarette": 0, "Gummy": 0}
	},
	"dialog" : {
		"0" : "Default dialog"
	}
}

var T : Dictionary = {
	"username" : "@AndSheWasAFairy",
	"post1" : null,
	"post2" : null,
	"post3" : null,
	"age" : "17",
	"sex" : "F",
	"mood" : 0,
	"illness" : "",
	"record" : ""
}

var S : Dictionary = {
	"username" : "@throwaway193843201",
	"post1" : null,
	"post2" : null,
	"post3" : null,
	"age" : "29",
	"sex" : "M",
	"mood" : 3,
	"illness" : "",
	"record" : ""
}

var B : Dictionary = {
	"username" : "@JaneDoe",
	"post1" : null,
	"post2" : null,
	"post3" : null,
	"age" : "32",
	"sex" : "F",
	"mood" : "Depressed",
	"illness" : "",
	"record" : ""
}

var R : Dictionary = {
	"username" : "@DailyFacts",
	"post1" : null,
	"post2" : null,
	"post3" : null,
	"age" : "35",
	"sex" : "M",
	"mood" : "Mad",
	"illness" : "",
	"record" : ""
}

var sex : Dictionary = {
	0 : "M",
	1 : "F"
}

func gen_char() -> Dictionary:
	var generated_char : Dictionary = client_template
	
	generated_char.username = gen_username()
	generated_char.age = randi_range(20, 75)
	generated_char.sex = sex.get(randi_range(0, 1))
	
	generated_char.mood = randi_range(0, 4)
	
	var number = randi_range(0, 100)
	if number > 0:
		generated_char.illness = DEF.illness.keys().pick_random()
	else:
		generated_char.illness = null

	number = randi_range(0, 100)
	if number > 90:
		generated_char.record = DEF.record.get(DEF.record.keys().pick_random())
	else:
		generated_char.record = null
	
	generated_char.post1 = gen_post()
	generated_char.post2 = gen_post()
	generated_char.post3 = gen_post()
	
	generated_char.order = gen_order()
	generated_char.dialog = gen_dialog(generated_char.order)
	generated_char.item = gen_items()
	
	char_generated.emit()
	return generated_char

func gen_username() -> String:
	var term1 = DEF.username.get("input1").pick_random()
	var term2 = DEF.username.get("input2").pick_random()
	var rand_num = randi_range(1, 99)
	var generated_username : String = "@" + term1 + term2 + str(rand_num)
	return generated_username

func gen_post() -> Dictionary:
	var post : Dictionary = {
		"text" : "text",
		"status" : false
	}
	
	var key = DEF.posts.keys().pick_random()
	var number = randi_range(0, 100)
	if number > 80:
		post.text = DEF.posts.get(key).get("head") + DEF.posts.get(key).bad_words.pick_random() + DEF.posts.get(key).get("tail")
		post.status = true
	else:
		post.text =DEF.posts.get(key).get("head") + DEF.posts.get(key).good_words.pick_random() + DEF.posts.get(key).get("tail")
		post.status = false
	
	return post

func gen_order() -> Dictionary:
	
	var order : Dictionary = {
		"drinks" : null,
		"foods" : null,
		"meds" : null,
		"extra" : null
	}
	var drinks : Dictionary
	drinks.assign(DEF.drink_reset)
	var foods : Dictionary
	foods.assign(DEF.food_reset)
	var meds : Dictionary
	meds.assign(DEF.health_reset)
	var extra : Dictionary
	extra.assign(DEF.extra_reset)
	
	var number = randi_range(0, 100)
	if number < 90:
		drinks[drinks.keys().pick_random()] += 1
	if number > 95:
		drinks[drinks.keys().pick_random()] += 1
		drinks[drinks.keys().pick_random()] += 1
	
	number = randi_range(0, 100)
	foods[foods.keys().pick_random()] += 1
	if number > 80:
		foods[foods.keys().pick_random()] += 1
	
	number = randi_range(0, 100)
	if number > 70:
		meds[meds.keys().pick_random()] += 1
	
	if number < 20:
		extra[extra.keys().pick_random()] += 1
	
	order.drinks = drinks
	order.foods = foods
	order.meds = meds
	order.extra = extra
	
	return order

func gen_items() -> Dictionary:
	var item : Dictionary
	item.assign(DEF.cart_reset)
	
	var number = randi_range(0, 100)
	var i
	if number < 30:
		i = 2
	elif number > 70:
		i = 4
	else:
		i = 3
	
	while i != 0:
		var key = item.keys().pick_random()
		item[key] += 1
		i -= 1
	
	return item

func gen_dialog(order : Dictionary) -> Dictionary:
	var dialog : Dictionary = {"0" : {
		"name" : "random",
		"expression" : "none",
		"text" : "Default dialog"
	}}
	var item_list : String = ""
	for key in order.keys():
		for keys in order[key].keys():
			if order[key].get(keys) > 0:
				for name_key in DEF.drink_item.keys():
					if DEF.drink_item[name_key].get("id") == keys:
						item_list = item_list + DEF.drink_item[name_key].get("name")
						item_list += ", "
				for name_key in DEF.food_item.keys():
					if DEF.food_item[name_key].get("id") == keys:
						item_list = item_list + DEF.food_item[name_key].get("name")
						item_list += ", "
				for name_key in DEF.health_item.keys():
					if DEF.health_item[name_key].get("id") == keys:
						item_list = item_list + DEF.health_item[name_key].get("name")
						item_list += ", "
				for name_key in DEF.extra_item.keys():
					if DEF.extra_item[name_key].get("id") == keys:
						item_list = item_list + DEF.extra_item[name_key].get("name")
						item_list += ", "

	var key = DEF.dialog.keys().pick_random()
	var head = DEF.dialog.get(key).get("head")
	var tail = DEF.dialog.get(key).get("tail")
	item_list = item_list.left(item_list.length() - 2)

	dialog["0"]["text"] = head + item_list + tail
	
	return dialog
