extends CharacterBody2D

var max_hits: int = 3
var current_hits: int = 0

var speed: float = 100.0
var direction: Vector2 = Vector2.RIGHT

var left_boundary: float = 16668.0
var right_boundary: float = 21000.0

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	position.x = left_boundary
	animated_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

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
