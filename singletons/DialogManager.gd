extends Node

var is_in_dialog := false

func start(timeline_name:String):
	if not is_in_dialog:
		var dialog = Dialogic.start(timeline_name)
		get_tree().paused = true
		is_in_dialog = true
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect("timeline_end", self, "unpause")
		add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false
	is_in_dialog = false
