extends KinematicBody2D

const ACCELERATION = 500 # przyśpieszenie - aby gracz od razu na max speed się nie poruszał
const MAX_SPEED = 80 # maksymalna prędkość
const FRICTION = 500 # symulacja bezwładności, bez tego gracz będzie się zatrzymywał jak na lodzie
var velocity = Vector2.ZERO # 0, prędkość 

var NPC : DialogNPC;
var isInDialog : bool = false;
var DialogNode : CanvasLayer;

onready var interactionTimer = $InteractionCD;

func _ready():
	$InteractionArea.connect("body_entered", self, "_onInteractionAreaEntered");
	$InteractionArea.connect("body_exited", self, "_onInteractionAreaLeft");
	interactionTimer.connect("timeout", self, "_onInteractionCD");

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

func _input(event):
	if event.is_action("action"):
		handle_action_input();
				
func handle_action_input():
	# check if dialog node already exist
	# we don't want two dialog at the same time
	if get_node_or_null("DialogNode") == null:
		if NPC and not isInDialog:
			# pause game
			get_tree().paused = true
			DialogNode = Dialogic.start(NPC.DialogueTimelineName)
			# get_tree().paused stop EVERYTHING
			# we don't want our dialog to be paused
			DialogNode.pause_mode = Node.PAUSE_MODE_PROCESS
			DialogNode.connect("timeline_end", self, "_onTimelineEnded")
			add_child(DialogNode)
			isInDialog = true;

func _onTimelineEnded(timeline_name):
	get_tree().paused = false
	DialogNode.queue_free();
	# this timer is necessary for now because of how Dialogic input is handled
	# When using E on keyboard, both accept event and dialog event fire, and the 
	# dialog starts in the same frame as it ends
	interactionTimer.start();

# very naive but for now will do. Definitely will need to be reworked later
func _onInteractionAreaEntered(body):
	NPC = body as DialogNPC;

func _onInteractionAreaLeft(body):
	NPC = null;
		
func _onInteractionCD():
	isInDialog = false;
