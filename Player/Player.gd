#extends KinematicBody2D
#
#const ACCELERATION = 500 # przyśpieszenie - aby gracz od razu na max speed się nie poruszał
#const MAX_SPEED = 80 # maksymalna prędkość
#const FRICTION = 500 # symulacja bezwładności, bez tego gracz będzie się zatrzymywał jak na lodzie
#var velocity = Vector2.ZERO # 0, prędkość 
#
#func _physics_process(delta):
#	var input_vector = Vector2.ZERO # vector w kierunku którego gracz się porusza
#	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") # ruch lewo/prawo
#	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") # ruch góra/dół
#	input_vector = input_vector.normalized() # po skosie porusza się tak jak normalnie w 4 strony, nie porusza się szybciej
#	if input_vector != Vector2.ZERO: # jeśli gracz ma się poruszyć
#		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta) # zastosowanie przyśpieszenia, co klatkę będzie velocity zwiększać aż będzie max
#	else: # jeśli ma się zatrzymać
#		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)# symulacja bezwładności
#
#	velocity = move_and_slide(velocity) # porusza gracza o podane velocity i sprawdza kolizje a jak na taką natrafi to się po niej "ślizga"
#	$AnimationPlayer.play("side_walk")

extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var FRICTION = 500

enum {
	MOVE,
	ATTACK,
	PICK_UP
}

var state = MOVE
var velocity = Vector2.ZERO

onready var animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')

func _ready():
	randomize()
	animationTree.active = true

func _physics_process(delta):
	if Input.is_action_just_pressed("action"):
		state = PICK_UP
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state()
		PICK_UP:
			pick_state()
	state=MOVE
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animationTree.set('parameters/idle/blend_position', input_vector)
		animationTree.set('parameters/walk/blend_position', input_vector)
		animationTree.set('parameters/attack/blend_position', input_vector)
		animationState.travel("walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel('idle')
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if input_vector.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	velocity = move_and_slide(velocity)

func attack_state():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	velocity = Vector2.ZERO
	animationState.travel('attack')

func pick_state():
	animationState.travel('pick_up')
