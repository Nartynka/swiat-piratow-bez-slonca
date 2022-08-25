extends CanvasLayer

func _ready():
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.connect("mana_change", self, "update_mana")

func update_mana(new_value):
	$ManaBar.value = new_value

func _process(delta):
	if DialogManager.is_in_dialog:
		visible = false
	else:
		visible = true
