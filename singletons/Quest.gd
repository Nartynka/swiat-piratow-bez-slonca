extends Node

"""
Minimal quest system implementation.
A dictionary where each string key represents a quest and an int value represanting a status
"""

enum STATUS { NONEXISTENT, STARTED, COMPLETE }

# List of all started or completed quests
var quest_list = {}

# Get the status of a quest. If it's not found it returns STATUS.NONEXISTENT
func get_status(quest_name:String) -> int:
	if quest_list.has(quest_name):
		return quest_list[quest_name]
	else:
		return STATUS.NONEXISTENT

func change_status(quest_name:String, status:int):
	if quest_list.has(quest_name):
		quest_list[quest_name] = status
	else:
		print("Non existing quest: "+quest_name)

# Start a new quest or return false if already exist
func accept_quest(quest_name:String) -> bool:
	if quest_list.has(quest_name):
		return false
	else:
		quest_list[quest_name] = STATUS.STARTED
		#print(quest_name + " accepted")
		return true

# List all the quest in a certain status
# For future GUI
#func list(status:int) -> Array:
#	if status == -1:
#		return quest_list.keys()
#	var result = []
#	for quest in quest_list.keys():
#		if quest_list[quest] == status:
#			result.append(quest)
#	return result
#	pass
#
# For future save
#func get_quest_list() -> Dictionary:
#	return quest_list.duplicate()
