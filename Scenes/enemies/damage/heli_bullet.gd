extends CharacterBody2D

var speed: float = 500.0

func _ready():
	velocity = Vector2(speed, 0)

func _process(delta):
	position += velocity * delta

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemies"):
		area.queue_free()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
