extends Button

var start_focused = false

func _ready():
	if(start_focused):
		grab_focus()
	connect("mouse_entered",self,"_on_Button_mouse_entered")

func _on_Button_mouse_entered():
	grab_focus()
