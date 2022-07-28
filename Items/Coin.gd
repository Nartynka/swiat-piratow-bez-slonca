extends Area2D

export(String) var item_name = "Gold_Coin"

func _on_body_entered(body):
	if body.name == "Player":
		Inventory.add_item(item_name, 1)
		queue_free()
