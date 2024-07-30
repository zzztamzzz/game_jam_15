extends CharacterBody2D

# Number of hits the enemy can take before being destroyed
var max_hits: int = 3
# Current number of hits the enemy has taken
var current_hits: int = 0

# Bullet scene
var Bullet = preload("res://Scenes/enemies/damage/heli_bullet.tscn")

# Firing interval
var fire_interval: float = 1.0
var time_since_last_fire: float = 0.0

# Reference to the fire point
@onready var fire_point = $fire_point
# Reference to the AnimatedSprite
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	# Connect the animation_finished signal
	animated_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _process(delta):
	# Handle firing
	time_since_last_fire += delta
	if time_since_last_fire >= fire_interval:
		fire_bullet()
		time_since_last_fire = 0.0

func fire_bullet():
	# Play firing animation
	animated_sprite.play("charge")

func _on_animation_finished(anim_name):
	if anim_name == "charge":
		# Instance a new bullet
		var bullet_instance = Bullet.instantiate()
		# Set the bullet's position to the fire point's position
		bullet_instance.position = fire_point.global_position
		# Add the bullet to the scene tree
		get_parent().add_child(bullet_instance)

func _on_area_2d_area_entered(area):
	# Increment the hit counter
	current_hits += 1
	
	# Destroy the bullet
	area.get_parent().queue_free()
	
	# Check if the enemy has taken enough hits
	if current_hits >= max_hits:
		queue_free()
