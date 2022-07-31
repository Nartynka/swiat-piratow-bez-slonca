extends StaticBody2D

var active = false
export(String) var character_name = "NPC"
var quest_list = []

func _ready():
	for child in get_children():
		var regex = RegEx.new()
		# Match node name that starts with "Quest" and ends with 0 or more number
		# e.g. "Quest", "Quest4", "Quest20" 
		regex.compile("^(Quest)\\d*$")
		if regex.search(child.name):
			quest_list.append(child)

func _input(event):
	if event.is_action_pressed("action"):
		if active and quest_list:
			var quest = quest_list[0]
			quest.start_quest()
			return
		if !quest_list:
			DialogManager.start("Default")

func _on_TriggerArea_body_entered(body):
	if body.name == "Player":
		active = true


func _on_TriggerArea_body_exited(body):
	if body.name == "Player":
		active = false
