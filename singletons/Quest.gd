extends Node

"""
Minimal quest system implementation.

A dictionary where each string key represents a quest and an int value represanting a status
"""

enum STATUS { NONEXISTENT, STARTED, COMPLETE }


# Emitted whenever a quests changes. It'll pass the quest name and new status
signal quest_changed(quest_name, status)

var quest_list = {}

# Get the status of a quest. If it's not found it returns STATUS.NONEXISTENT
func get_status(quest_name:String) -> int:
	if quest_list.has(quest_name):
		return quest_list[quest_name]
	else:
		return STATUS.NONEXISTENT
	pass

# For future GUI
func get_status_as_text(quest_name:String) -> int:
	var status = get_status(quest_name)
	return STATUS.keys()[status]


# Change state of some quest
func change_status(quest_name:String, status:int) -> bool:
	if quest_list.has(quest_name):
		quest_list[quest_name] = status
		emit_signal("quest_changed", quest_name, status)
		return true
	else:
		return false
	pass

# Start a new quest
func accept_quest(quest_name:String):
	if quest_list.has(quest_name):
		print("Quest already exist")
	else:
		quest_list[quest_name] = STATUS.STARTED
		print(quest_name + " accepted")
		emit_signal("quest_changed", quest_name, STATUS.STARTED)
	pass


# List all the quest in a certain status
# For future GUI
func list(status:int) -> Array:
	if status == -1:
		return quest_list.keys()
	var result = []
	for quest in quest_list.keys():
		if quest_list[quest] == status:
			result.append(quest)
	return result
	pass
	
# For future save
func get_quest_list() -> Dictionary:
	return quest_list.duplicate()
