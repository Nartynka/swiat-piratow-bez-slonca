extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused

func _on_Reasume_pressed():
	self.is_paused = false

func _on_NewGameBtn_pressed():
	get_tree().change_scene("res://House.tscn")

func _on_SettingsBtn_pressed():
	get_tree().change_scene("res://UI/Settings/SettingsScreen.tscn")

func _on_QuitBtn_pressed():
	get_tree().quit()
