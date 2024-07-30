extends Sprite2D

@export var speed = 900
var direction = Vector2.ZERO

func _ready():
	scale = Vector2(0.5, 0.5)
	# Ensure the bullet direction is normalized
	direction = direction.normalized()

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
