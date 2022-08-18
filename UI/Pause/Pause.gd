extends Control

func _physics_process(_delta):
	if Input.is_action_just_pressed("pause"):
		if !self.visible:
			self.show()
			$Background/VBoxContainer/ReasumeBtn.grab_focus()
			get_tree().paused = true
		else:
			hide_pause()
			


func hide_pause():
	self.hide()
	get_tree().paused = false



func _on_ReasumeBtn_pressed():
	hide_pause()


func _on_MainMenuBtn_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
	
func _on_QuitBtn_pressed():
	get_tree().quit()
