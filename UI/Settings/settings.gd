extends Control

onready var fullscreenBtn = $FullscreenBtn
onready var muteBtn = $MuteBtn

func _ready():
	fullscreenBtn.grab_focus()
	fullscreenBtn.pressed = Screen.is_fullscreen

func _on_BackBtn_pressed():
	get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")


func _on_FullscreenBtn_toggled(button_pressed):
	Screen.set_screen(button_pressed)

func _on_MuteBtn_toggled(button_pressed):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), button_pressed)
