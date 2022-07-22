extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		Inventory.add_item("Gold Coin", 1)
		queue_free()
