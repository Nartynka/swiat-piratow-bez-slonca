extends KinematicBody2D

const ACCELERATION = 2000
const MAXspeed = 400
const FRICTION = 2000
var velocity= Vector2.ZERO

func _process(delta):
	var inputvector = Vector2.ZERO
	inputvector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputvector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputvector = inputvector.normalized()
	
	if inputvector != Vector2.ZERO:
		velocity = velocity.move_toward(inputvector * MAXspeed, ACCELERATION * delta)
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
