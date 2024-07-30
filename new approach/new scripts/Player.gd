extends CharacterBody2D

# Speed of the player
@export var speed = 200
@export var jump_force = -400

# Bullet scene
@export var bullet_scene: PackedScene

# Move direction of the player
var move_direction = Vector2.ZERO

# Animation Player
@onready var anim_sprite = $AnimatedSprite2D

func _physics_process(delta):
	move_direction = Vector2.ZERO
	
	# Get input for movement
	if Input.is_action_pressed("moveRight"):
		move_direction.x += 1
		anim_sprite.play("walking")
		anim_sprite.flip_h = false
	elif Input.is_action_pressed("moveLeft"):
		move_direction.x -= 1
		anim_sprite.play("walking")
		anim_sprite.flip_h = true
	else:
		anim_sprite.play("idling")

	if Input.is_action_just_pressed("jump") and is_on_floor():
		move_direction.y = jump_force
		anim_sprite.play("jumping")

	move_direction = move_direction.normalized() * speed
	move_and_slide(move_direction)

	# Handle shooting
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	if anim_sprite.flip_h:
		bullet.rotation_degrees = 180
		bullet.speed = -bullet.speed
	get_parent().add_child(bullet)
