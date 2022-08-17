extends NinePatchRect

onready var questLabel = $QuestLabel

func _physics_process(delta):
	rect_size.x = questLabel.rect_size.x + 5

func _ready():
	Quest.connect("quest_changed", self, "_on_quest_changed")
	
func _on_quest_changed(name, status):
	questLabel.text = name + " ("+status+")"
