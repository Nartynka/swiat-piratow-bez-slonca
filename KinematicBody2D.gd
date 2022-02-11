extends KinematicBody2D

const ACCELERATION = 500 # przyśpieszenie - aby gracz od razu na max speed się nie poruszał
const MAX_SPEED = 80 # maksymalna prędkość
const FRICTION = 500 # symulacja bezwładności, bez tego gracz będzie się zatrzymywał jak na lodzie
var velocity = Vector2.ZERO # 0, prędkość 

func _physics_process(delta):
	var input_vector = Vector2.ZERO # vector w kierunku którego gracz się porusza
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") # ruch lewo/prawo
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") # ruch góra/dół
	input_vector = input_vector.normalized() # po skosie porusza się tak jak normalnie w 4 strony, nie porusza się szybciej
	if input_vector != Vector2.ZERO: # jeśli gracz ma się poruszyć
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta) # zastosowanie przyśpieszenia, co klatkę będzie velocity zwiększać aż będzie max
	else: # jeśli ma się zatrzymać
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)# symulacja bezwładności
	
	velocity = move_and_slide(velocity) # porusza gracza o podane velocity i sprawdza kolizje a jak na taką natrafi to się po niej "ślizga"
