extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("action"):
		$AnimationPlayer.stop(true)
		$AnimationPlayer.play("RESET")
