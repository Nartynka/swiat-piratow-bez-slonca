extends NinePatchRect

onready var questLabel = $VBoxContainer/QuestLabel

func _ready():
	Quest.connect("quest_changed", self, "_on_quest_changed")
	
func _on_quest_changed(name, status):
	questLabel.text = name + " ("+status+")"
