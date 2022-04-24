extends Area2D

var active = false
export(String) var character_name = "Nameless NPC"
#export(Array, String, MULTILINE) var dialogs = ["Nic dla ciebie nie mam"]
var quest_list = []
var is_in_dialog = false

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
			if not is_in_dialog:
				var dialog = Dialogic.start("Default")
				get_tree().paused = true
				is_in_dialog = true
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect("timeline_end", self, "unpause")
				add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false
	is_in_dialog = false

func _on_body_entered(body):
	if body.name == "Player":
		active = true
		
func _on_body_exited(body):
	if body.name == "Player":
		active = false
