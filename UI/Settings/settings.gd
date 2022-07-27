extends Node2D

onready var drop_down_menu = $OptionButton

func _ready():
	add_items()

func add_items():
	drop_down_menu.add_item("1024x546")
	drop_down_menu.add_item("1280x720")
	drop_down_menu.add_item("1600x900")
	drop_down_menu.add_item("1920x1080")
	drop_down_menu.select(1)


func _on_OptionButton_item_selected(index):
	var current_selected = index
	
	if current_selected == 0:
		OS.set_window_size(Vector2(1024,546))
	if current_selected == 1:
		OS.set_window_size(Vector2(1280,720))
	if current_selected == 2:
		OS.set_window_size(Vector2(1600,900))
	if current_selected == 3:
		OS.set_window_size(Vector2(1920,800))


func _on_BackBtn_pressed():
	get_tree().change_scene("res://UI/MainMenu/MainMenu.tscn")
