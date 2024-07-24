#extends Node
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
class EnemyAI extends KinematicBody:

	# Detection zone radius
	var detection_radius = 5.0

	# Target player
	var target_player: Player

	# Enemy health
	var health = 100

	func _ready():
		# Find the player node in the scene
		target_player = get_node("/root/Player")

	func _process(delta):
		# Check if the player is within detection zone
		if target_player.position.distance_to(position) <= detection_radius:
			# Attack the player
			attack_player()
		else:
			# Roam around
			roam()

	func roam():
		# Get a random direction within a circle
		var direction = Vector3.random_in_sphere(1.0)

		# Move the enemy in the direction
		move_and_slide(direction)

	func attack_player():
		# Target the player
		target_player.target = self

		# Attack the player
		# ... (Add attack logic here)

	func take_damage(damage):
		# Reduce enemy health
		health -= damage

		# Check if the enemy is dead
		if health <= 0:
			# Enemy dies
			queue_free()
