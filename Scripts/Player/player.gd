extends CharacterBody2D

# Preloads and constants
var shooting_bullet = preload("res://Scenes/Player/bullet.tscn")

# Script for player movement mechanics, shootting movement ... 

var walk_speed = 400
var jump_force = 500
var gravity = 10
var horizontal_directions = Vector2.ZERO

func _physics_process(delta: float) -> void:
	handle_movement()
	apply_gravity()
	handle_jumping()
	handle_dashing()
	
	move_and_slide()

func handle_movement():
	horizontal_directions = Input.get_axis("moveLeft", "moveRight")
	if horizontal_directions != 0:
			velocity.x = walk_speed * horizontal_directions
	else:
		velocity.x = 0
		
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

func handle_dashing():
	if Input.is_action_just_pressed("dash"):
		velocity.x += 10 * walk_speed
		
