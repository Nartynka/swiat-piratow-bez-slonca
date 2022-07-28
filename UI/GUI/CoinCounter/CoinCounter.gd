extends NinePatchRect

func _ready():
	Inventory.connect("inventory_change", self, "_on_item_change")
	
func _on_item_change(type, amount):
	if type == "Gold_Coin":
		$Label.text = str(amount)
