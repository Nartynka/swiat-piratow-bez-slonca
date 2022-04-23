extends Area2D



func _on_Coin_body_entered(body):
	pass # Replace with function body.


func _on_body_entered(body):
	if body.name == "Player":
		Inventory.add_item("Gold Coin", 1)
		queue_free()
