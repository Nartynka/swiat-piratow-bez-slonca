extends Node

onready var vp = get_tree().get_root()
onready var base_size = Vector2(1920, 1080)

export(bool) var is_fullscreen = true

func _ready():
	set_screen(is_fullscreen)

func set_screen(is_fullscreen):
	if is_fullscreen:
		set_fullscreen()
	else:
		set_windowed()


func set_fullscreen():
	OS.set_window_fullscreen(true)

func set_windowed():
	var window_size = OS.get_screen_size()
	# I set the windowed version to 80% of screen size
	var scale = min(window_size.x / base_size.x, window_size.y / base_size.y) * 0.8
	var scaled_size = (base_size * scale).round()
	
	var window_x = (window_size.x / 2) - (scaled_size.x / 2)
	var window_y = (window_size.y / 2) - (scaled_size.y / 2)
	OS.set_borderless_window(false)
	OS.set_window_fullscreen(false)
	OS.set_window_position(Vector2(window_x, window_y))
	OS.set_window_size(scaled_size)
	vp.set_size(scaled_size)
