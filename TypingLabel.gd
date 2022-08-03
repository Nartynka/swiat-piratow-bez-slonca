extends RichTextLabel

var lapsed = 0

func _ready():
	set_physics_process(false)

func set_lapsed():
	lapsed = 0

func _physics_process(delta):
	lapsed += delta
	visible_characters = lapsed/0.1
	
func new_text(ntext:String):
	clear()
	text = ntext
	set_lapsed()
