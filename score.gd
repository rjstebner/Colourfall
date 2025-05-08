extends TextureRect

@export var player: NodePath  # Assign the player node in the editor

var elapsed_time: float = 0.0
var score_time = 0.0
var combo = 0

func _process(delta: float) -> void:
	if player:
		var player_node = get_node(player)
		# Update the score's Y position to match the player's Y position
		position.y = player_node.global_transform.origin.y
	
	elapsed_time += delta

	$Count.text = str(round(elapsed_time * 10) / 10.0)


func _score_up():
	
	var rounded_time = round(elapsed_time * 10) / 10.0

	rounded_time = rounded_time * combo
	score_time += rounded_time
	
	$Score.text = str(score_time)
	elapsed_time = 0.0
	combo = 0
	$Combo.text = str(combo)
	$Combo.modulate = Color(1, 1, 1)  # White

func _combo_up():
	combo +=1
	$Combo.text = str(combo)
    # Change the color of the Combo label based on the combo number

	match combo / 10:
		0:
			$Combo.modulate = Color(1, 1, 1)  # White
		1:
			$Combo.modulate = Color(0, 1, 0)  # Green
		2:
			$Combo.modulate = Color(0, 0, 1)  # Blue
		3:
			$Combo.modulate = Color(1, 0, 0)  # Red
		_:
			$Combo.modulate = Color(1, 1, 0)  # Yellow for combos >= 5