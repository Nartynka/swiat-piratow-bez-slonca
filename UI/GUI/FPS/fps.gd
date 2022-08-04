extends Label

func _process(delta):
	set_text("FPS: %d" % Engine.get_frames_per_second())
	if Screen.fps_mode:
		show()
	else:
		hide()
	

