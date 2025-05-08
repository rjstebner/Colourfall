extends Area2D



@export var obstacle_colour: Color = Color.BLACK
var score_board: TextureRect
var bounce_speed: int = -100



func _ready():
	$Sprite2D.modulate = obstacle_colour
	connect("body_entered", Callable(self, "_on_body_entered"))
	score_board = get_tree().get_first_node_in_group("Scoreboard")
	if score_board == null:
		print("Scoreboard not found in the scene tree. Please ensure it is added to the group 'ScoreBoardGroup'.")

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	
	var player_colour = body.current_colour

	if obstacle_colour == Color.WHITE:
		body.velocity.y = bounce_speed #bounce
		score_board._score_up()
		
	
	elif obstacle_colour == Color.BLACK:
		print("YOU LOSE")
		#add death animation
		#add death sound
		#add death screen
		#add reset button

		get_tree().reload_current_scene()

	elif player_colour == obstacle_colour:
		score_board._combo_up()
		pass
		#add sound
		#add particle effect


#opposites I don't know what to do, tbh
	#elif _are_opposites(obstacle_colour, player_colour):
	#	print("YOU LOSE")
		#add death animation
		#add death sound
		#add death screen
		#add reset button
	#	get_tree().reload_current_scene()

	elif obstacle_colour == Color(0,1,1):
		body._start_round()
		print("YOU WIN")




	else:

		body.velocity.y = bounce_speed #bounce
		score_board._score_up()

func _are_opposites(colour1: Color, colour2: Color) -> bool:
	return (colour1 == Color.RED and colour2 == Color.GREEN) or \
		(colour1 == Color.GREEN and colour2 == Color.RED) or \
		(colour1 == Color.YELLOW and colour2 == Color(1,0,1)) or \
		(colour1 == Color(1,0,1) and colour2 == Color.YELLOW)
