extends CharacterBody2D

@export var spawners: Array[Node] = []  # List of spawners in the scene

@export var gravity: float = 100.0  # Controls how fast the character accelerates
@export var max_fall_speed: float = 400.0  # Limits the maximum fall speed

var current_colour: Color = Color.WHITE

var colour_map = {
	"a": Color.RED,
	"s": Color.GREEN,
	"d": Color.YELLOW,
	"f": Color(1, 0,1),  # Magenta
}

func _ready():
	$Sprite2D.modulate = current_colour

	# Check if spawners array is populated, if not, attempt to fetch nodes in the scene
	if spawners.is_empty():
		spawners = get_tree().get_nodes_in_group("Spawner")

func _physics_process(delta):
	velocity.y += gravity * delta  # Gradual acceleration
	velocity.y = min(velocity.y, max_fall_speed)  # Clamp to max fall speed

	if Input.is_action_pressed("ui_left"):
		velocity.x = -240
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 240
	else:
		velocity.x = 0

	 # Spin the player based on fall speed
	$Sprite2D.rotation += velocity.y * delta * 0.02  # Adjust the multiplier (0.01) to control spin speed


	for key in colour_map.keys():
		if Input.is_action_pressed(key):
			current_colour = colour_map[key]
			$Sprite2D.modulate = current_colour
			break
	

	move_and_slide()


func _start_round():
	if spawners.is_empty():
		print("No spawners found!")
		return

	var start_y = position.y + 300

	var current_spawner = spawners[0]
	if current_spawner:
		current_spawner.call("_fill_map", start_y)
		print("Starting round at y:", start_y)

	# Remove the used spawner from the list so the next one gets used next time
	spawners.remove_at(0)
