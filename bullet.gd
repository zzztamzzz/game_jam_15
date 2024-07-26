extends CharacterBody2D

@export var speed = 500.0
var direction = Vector2()

func _physics_process(delta):
	position += direction * speed * delta

func _look_at(target):
	direction = (target - position).normalized()
