extends AudioStreamPlayer2D

func _ready():
	if stream:
		stream.loop = true
	play()
