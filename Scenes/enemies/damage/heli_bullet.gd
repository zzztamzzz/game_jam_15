extends CharacterBody2D

# Speed at which the bullet moves
var speed: float = 500.0

func _ready():
	# Set initial velocity or any setup needed for the bullet
	velocity = Vector2(speed, 0)  # Moves to the right; adjust as needed

func _process(delta):
	# Move the bullet
	position += velocity * delta

func _on_area_2d_area_entered(area):
	# Handle collision with other areas
	if area.is_in_group("enemies"):
		area.queue_free()  # Destroy the enemy
		queue_free()  # Destroy the bullet


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

