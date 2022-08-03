extends Camera2D
var shake_amount = 1.0

var stop = true

func _ready():
	set_process(false)

func _process(delta):
#	if stop:
#		return
	set_offset(Vector2( \
		rand_range(-1.0, 1.0) * shake_amount, \
		rand_range(-1.0, 1.0) * shake_amount \
	))

#func stop(foo):
#	stop = foo
