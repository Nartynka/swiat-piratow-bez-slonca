extends Area2D

func _on_Portal_body_entered(body):
#	$ShakeCamera2D.add_trauma(0.25)
	if body.name == "Player":
#		$"../ShakeCamera2D".add_trauma(0.7)
		SceneChange.change_scene("res://World.tscn")
