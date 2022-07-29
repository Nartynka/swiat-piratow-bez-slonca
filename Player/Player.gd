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
var input_vector = Vector2.ZERO
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get('parameters/playback')

func _ready():
	animationTree.active = true

func _physics_process(delta):
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
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
	if input_vector.x < 0:
		$Sprite.flip_h = false
	velocity = move_and_slide(velocity)

func attack_state():
	if input_vector.x > 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	velocity = Vector2.ZERO
	animationState.travel('attack')

func pick_state():
	animationState.travel('pick_up')
