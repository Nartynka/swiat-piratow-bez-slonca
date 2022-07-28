extends Node

"""
Minimal inventory system implementation. 
It's just a dictionary where items are identified by a string key and hold an int amount
"""

# action can be 'added' some amount of some items is added and 'removed' when some amount
# of some item is removed
signal change_item(action, type, amount)
signal inventory_change(type, amount)

var inventory = {}

func get_item(type:String) -> int:
	if inventory.has(type):
		return inventory[type]
	else:
		return 0
	
func add_item(type:String, amount:int):
	if inventory.has(type):
		inventory[type] += amount
		emit_signal("change_item", "added", type, amount)
	else:
		inventory[type] = amount
		emit_signal("change_item", "added", type, amount)
	update_gui(type)
	
func remove_item(type:String, amount:int):
	if inventory.has(type) and inventory[type] >= amount:
		inventory[type] -= amount
#		if inventory[type] == 0:
#			inventory.erase(type)
		emit_signal("change_item", "removed", type, amount)
	update_gui(type)

# for future save
#func list() -> Dictionary:
#	return inventory.duplicate()

func update_gui(type):
	emit_signal("inventory_change", type, inventory[type])
