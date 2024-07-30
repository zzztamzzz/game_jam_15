extends CharacterBody2D

# Number of hits the enemy can take before being destroyed
var max_hits: int = 3
# Current number of hits the enemy has taken
var current_hits: int = 0

# Movement speed and direction
var speed: float = 100.0
var direction: Vector2 = Vector2.RIGHT

# Movement boundaries
var left_boundary: float = 16668.0
var right_boundary: float = 21000.0

func _ready():
	# Set initial position
	position.x = left_boundary

func _process(delta):
	# Move the enemy
	position += direction * speed * delta

	# Check boundaries and reverse direction if necessary
	if position.x < left_boundary:
		direction = Vector2.RIGHT
	elif position.x > right_boundary:
		direction = Vector2.LEFT

func _on_area_2d_area_entered(area):
	# Increment the hit counter
	current_hits += 1
	
	# Destroy the bullet
	area.get_parent().queue_free()
	
	# Check if the enemy has taken enough hits
	if current_hits >= max_hits:
		queue_free()
