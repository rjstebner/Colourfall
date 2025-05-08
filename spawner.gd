extends Node

@export var obstacle_scenes: Array[PackedScene] = []
@export var spawn_yoffset: float = 200 # how far above the player the spawner floats
@export var left_edge: int = 390   
@export var right_edge: int = 810
@export var columns: int = 8
@export var column_width: int = 55
@export var map_height: int = 2600  # Total height of the map to fill
@export var fill_percent: float = 0.5  # Percentage of the map to fill with obstacles

var player


# Function to fill the map with rows of obstacles
func _fill_map(start_y: float):
    print("is this working")
    var y = start_y  # Start at the first spawn offset
    var end_y = start_y + map_height  # Calculate the end y position
    while y < end_y:
        _spawn_row(y)
        y += spawn_yoffset  # Move down by the spawn offset

# Function to spawn a row of obstacles at a specific y position
func _spawn_row(y):
    var base_x = left_edge

    # Spawn obstacles across columns
    for i in range(columns):
        if randf() < fill_percent:  # 50% chance of spawning an obstacle
            var scene = obstacle_scenes.pick_random()
            var obstacle = scene.instantiate()
            call_deferred("add_child", obstacle)  # Defer adding the obstacle to the scene tree
            obstacle.position = Vector2(base_x + i * column_width, y)
            obstacle.z_index = -1