extends KinematicBody2D

var dialog_active = false

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		dialog_active = true

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		dialog_active = false
		
func _input(event):
	# check if dialog node already exist
	# we don't want two dialog at the same time
	if get_node_or_null("DialogNode") == null:
		if Input.is_action_just_pressed("action") and dialog_active:
			# pause game
			get_tree().paused = true
			var dialog = Dialogic.start("ines")
			# get_tree().paused stop EVERYTHING
			# we don't want our dialog to be paused
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect("timeline_end", self, "unpause")
			add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false
