extends CharacterBody2D

# Preloads and constants
var shooting_bullet = preload("res://Scenes/Player/bullet.tscn")
@onready var player_animations = $AnimatedSprite2D
@onready var bullet_origin = $Marker2D

# Script for player movement mechanics, player looking direction and shootting ... 

# Movement
var walk_speed = 400
var jump_force = 500
var gravity = 10

# Direction
var horizontal_directions = Vector2.ZERO
var facing_right = true

# Shooting
var can_shoot = true
var aim_direction = Vector2(1, 0)

# Dashing
var is_dashing = false
var can_dash = true

func _physics_process(delta: float) -> void:
	handle_movement()
	apply_gravity()
	handle_jumping()
	handle_dashing()
	handle_shooting()
	
	move_and_slide()

func handle_movement():
	horizontal_directions = Input.get_axis("moveLeft", "moveRight")
	if horizontal_directions != 0:
			velocity.x = walk_speed * horizontal_directions
	else:
		velocity.x = 0
	#player_animations.play("walking")
	
func apply_gravity():
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	else:
		velocity.y = 0

func handle_jumping():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = - jump_force
		#player_animations.play("jumping")

func handle_dashing():
	if Input.is_action_just_pressed("dash"):
		velocity.x += 10 * walk_speed
		player_animations.play("dashing")
		
func handle_shooting():
	if Input.is_action_just_pressed("shoot"):
		can_shoot = false
		var bullet_instance = shooting_bullet.instantiate()
		get_parent().add_child(bullet_instance)
		bullet_instance.global_position = bullet_origin.global_position
		bullet_instance.direction = aim_direction
		can_shoot = true
		#if can_shoot:
			#player_animations.play("shooting")
		#else: 
			#player_animations.play("idling")
