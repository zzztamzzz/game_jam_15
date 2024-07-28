extends CharacterBody2D

@export var speed = 300 # for inspector access
@export var gravity = 30
@export var jump_force = 700
@export var dash_force = 10000


# Bullet
var bullet = preload("res://Scenes/Bullet_basic.tscn")
var b_inst

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
	
	if Input.is_action_just_pressed("dash"):
		velocity.x = horizontal_direction + dash_force
	shoot()
	move_and_slide()

func shoot():
	if Input.is_action_just_pressed("shoot"):
	#if Input.is_action_pressed("shoot"): # full auto op
		b_inst = bullet.instantiate()
		get_parent().add_child(b_inst)
		b_inst.global_position = $Marker2D.global_position
