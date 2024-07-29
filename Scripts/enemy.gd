extends CharacterBody2D

@export var speed = 150
@export var damage = 1
@export var wait_time = 1.0

@onready var patrol_points = [
	$PatrolPoint1.global_position,
	$PatrolPoint2.global_position
]
var current_point = 0
var direction = Vector2.ZERO
var waiting = false

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	if patrol_points.size() > 0:
		set_direction()
	else:
		direction = Vector2.RIGHT

func _physics_process(_delta):
	if not waiting:
		velocity = direction * speed
		move_and_slide()
		if global_position.distance_to(patrol_points[current_point]) < 10:
			waiting = true
			direction = Vector2.ZERO
			animated_sprite.play("idle")
			await wait(wait_time)
			current_point = (current_point + 1) % patrol_points.size()
			set_direction()
			waiting = false
		else:
			animated_sprite.play("walk")

func set_direction():
	direction = (patrol_points[current_point] - global_position).normalized()
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func _on_Enemy_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(damage)
		# You can add any other interaction logic here

func wait(seconds):
	await get_tree().create_timer(seconds).timeout
