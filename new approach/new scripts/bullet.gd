extends RigidBody2D

export var speed = 400

func _ready():
	pass

func _integrate_forces(state):
	velocity = Vector2(speed, 0).rotated(rotation)
