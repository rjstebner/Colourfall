extends Area2D

@export var target_position: Vector2  # where to send the player

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.is_in_group("Player"):
		target_position.y = body.position.y
		body.global_position = target_position
