extends CharacterBody2D

@export var speed = 300 # for inspector access
@export var gravity = 30
@export var jump_force = 700
func _physics_process(delta):
	#pass
	
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
	var horizontal_direction = Input.get_axis("move left", "move right") 
	velocity.x = 300 * horizontal_direction
	move_and_slide()
	
	print(velocity)


# Template (Auto)
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
	## Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
