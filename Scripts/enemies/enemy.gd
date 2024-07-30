extends CharacterBody2D

var max_hits: int = 1
var current_hits: int = 0

var speed: float = 100.0
var direction: Vector2 = Vector2.RIGHT

var movement_range: float = 500.0

var left_boundary: float
var right_boundary: float

func _ready():
	left_boundary = position.x - movement_range / 2
	right_boundary = position.x + movement_range / 2

func _process(delta):
	position += direction * speed * delta

	if position.x < left_boundary:
		direction = Vector2.RIGHT
	elif position.x > right_boundary:
		direction = Vector2.LEFT

func _on_area_2d_area_entered(area):
	current_hits += 1
	area.get_parent().queue_free()
	if current_hits >= max_hits:
		queue_free()
