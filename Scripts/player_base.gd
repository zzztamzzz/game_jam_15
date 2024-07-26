extends CharacterBody2D

@export var speed = 300 # for inspector access
@export var gravity = 30
@export var jump_force = 700

# Shooting variables
var Bullet = preload("res://Scenes/Bullet.tscn") # Import the bullet scene
@export var shoot_cooldown = 0.5
var last_shot_time = 0

func _physics_process(_delta):
	# Vertical movement
	# Gravity
	if !is_on_floor(): # true for on floor and false otherwise
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	# Jump
	if Input.is_action_just_pressed("jump"): #&& is_on_floor():
		velocity.y = -jump_force

	# Horizontal movement
	var horizontal_direction = Input.get_axis("moveLeft", "moveRight")
	velocity.x = speed * horizontal_direction

	# Flip sprite based on input
	if horizontal_direction < 0:
		$hablu.flip_h = true
	elif horizontal_direction > 0:
		$hablu.flip_h = false

	# Shooting Logic
	if Input.is_action_pressed("shoot"):
		var current_time = Time.get_ticks_msec() / 1000
		if current_time - last_shot_time > shoot_cooldown:
			shoot()
			last_shot_time = current_time

			
	move_and_slide()

func shoot():
	var bullet = Bullet.instance()
	bullet.position = position + Vector2(16, 0) # Adjust this according to your game's needs
	bullet.look_at(get_viewport().get_visible_rect().size / 2)
	get_tree().root.add_child(bullet)
