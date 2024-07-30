extends CharacterBody2D

@export var speed = 300
@export var gravity = 20
@export var jump_force = 700
@export var dash_force = 1500
@export var shoot_cooldown = 0.2
@export var dash_duration = 0.6
@export var dash_cooldown = 1.0

@export var max_lives = 3
var lives = max_lives

var bullet = preload("res://Scenes/player/player_base_bullet.tscn")
var can_shoot = true
var can_dash = true
var is_dashing = false
var facing_right = true
var horizontal_direction = 0
var aim_direction = Vector2(1, 0)

@onready var animated_sprite = $AnimatedSprite2D
@onready var marker = $Marker2D

@export var marker_offset_right = Vector2(10, -6)
@export var marker_offset_left = Vector2(-10, -6)
@export var marker_offset_crouch = Vector2(10, 8)
@export var marker_offset_up = Vector2(0, 10)
@export var marker_offset_down = Vector2(0, -10)

func _ready():
	update_marker_position()

func _physics_process(_delta):
	apply_gravity()
	handle_jump()
	handle_movement()
	handle_dash()
	handle_crouch()
	handle_aim()
	if can_shoot:
		shoot()
	move_and_slide()
	update_animation()
	if lives <= 0:
		die()

func apply_gravity():
	if !is_on_floor() and !is_dashing:
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	else:
		velocity.y = 0

func handle_jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

func handle_movement():
	if !is_dashing:
		horizontal_direction = Input.get_axis("moveLeft", "moveRight")
		if horizontal_direction != 0:
			velocity.x = speed * horizontal_direction
			facing_right = horizontal_direction > 0
			animated_sprite.flip_h = not facing_right
			update_marker_position()
		else:
			velocity.x = 0

func handle_dash():
	if Input.is_action_just_pressed("dash") and can_dash:
		is_dashing = true
		can_dash = false
		animated_sprite.play("dashing")
		velocity.x = (dash_force if facing_right else -dash_force)
		await get_tree().create_timer(dash_duration).timeout
		is_dashing = false
		velocity.x = 0
		await get_tree().create_timer(dash_cooldown).timeout
		can_dash = true

func handle_crouch():
	if Input.is_action_pressed("crouch") and is_on_floor():
		animated_sprite.play("crouching")
		update_marker_position()
	else:
		update_marker_position()

func handle_aim():
	if Input.is_action_pressed("lookUp"):
		aim_direction = Vector2(0, -1)
	elif Input.is_action_pressed("lookDown") and !is_on_floor():
		aim_direction = Vector2(0, 1)
	else:
		aim_direction = Vector2(1, 0) if facing_right else Vector2(-1, 0)

func shoot():
	if Input.is_action_just_pressed("shoot"):
		can_shoot = false
		var b_inst = bullet.instantiate()
		get_parent().add_child(b_inst)
		b_inst.global_position = marker.global_position
		b_inst.direction = aim_direction
		await get_tree().create_timer(shoot_cooldown).timeout
		can_shoot = true

func update_animation():
	if is_dashing:
		return
	if Input.is_action_pressed("lookUp"):
		animated_sprite.play("lookingUp")
	elif not is_on_floor():
		animated_sprite.play("jumping")
	elif Input.is_action_pressed("crouch") and is_on_floor():
		animated_sprite.play("crouching")
	elif velocity.x != 0:
		animated_sprite.play("running")
	else:
		animated_sprite.play("idling")

func update_marker_position():
	if Input.is_action_pressed("lookUp"):
		marker.position = marker_offset_up
	elif Input.is_action_pressed("lookDown") and !is_on_floor():
		marker.position = marker_offset_down
	elif Input.is_action_pressed("crouch") and is_on_floor():
		marker.position = marker_offset_crouch
	else:
		marker.position = marker_offset_right if facing_right else marker_offset_left

func die():
	queue_free()
