extends AudioStreamPlayer


func _ready():
	volume_db = -10
	connect("finished", Callable(self, "loop"))
	play()

func loop():
	play()
