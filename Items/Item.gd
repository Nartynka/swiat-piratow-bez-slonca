extends Area2D

export(String) var item_name = "Gold_Coin"
var active = false

func _input(event):
	if active and event.is_action_pressed("pick_up"):
		Inventory.add_item(item_name, 1)
		$AudioStreamPlayer.play()
		yield(get_tree().create_timer(0.3), "timeout")
		queue_free()

func _on_Item_body_entered(body):
	if body.name == "Player":
		active = true

func _on_Item_body_exited(body):
	if body.name == "Player":
		active = false

func show():
	monitoring=true
	visible=true
