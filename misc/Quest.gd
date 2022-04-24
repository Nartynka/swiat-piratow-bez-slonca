extends Node

"""
Instance this as a child of any Npc.tscn node and it turns into a quest giver.

The character will also check if the player has a certain amount of a given item and if true
Remove said amount from the players inventory and give some amount of another item as a reward
"""

export(String) var quest_name = "Test Quest"

export(String) var required_item = "Generic Item"
export(int) var required_amount = 10
export(String) var reward_item = "Generic Reward"
export(int) var reward_amount = 1

export(String) var initial_dialog = "Test Quest"
export(String) var pending_dialog = "Test Quest Pending"
export(String) var delivered_dialog = "Test Quest Complete"

var is_in_dialog = false
var quest_status = Quest.STATUS.NONEXISTENT

func start_quest():
	var is_quest_new = Quest.accept_quest(quest_name)
	if is_quest_new:
		start_dialog(initial_dialog)
	else:
		process()
	
func process():
	quest_status = Quest.get_status(quest_name)
	match quest_status:
		Quest.STATUS.NONEXISTENT:
			start_quest()
		Quest.STATUS.STARTED:
			if Inventory.get_item(required_item) >= required_amount:
				Quest.change_status(quest_name, Quest.STATUS.COMPLETE)
				process()
			else:
				start_dialog(pending_dialog)
		Quest.STATUS.COMPLETE:
			Inventory.remove_item(required_item, required_amount)
			Inventory.add_item(reward_item, reward_amount)
			get_parent().quest_list.pop_front()
			start_dialog(delivered_dialog)
			#print(quest_name+" completed")
		_:
			return

func start_dialog(timeline_name):
	if not is_in_dialog:
		var dialog = Dialogic.start(timeline_name)
		get_tree().paused = true
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		is_in_dialog = true
		dialog.connect("timeline_end", self, "unpause")
		add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false
	is_in_dialog = false
