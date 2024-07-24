#extends Node
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

# Create a HealthBar and StaminaBar node in the scene
health_bar = HealthBar.new()
stamina_bar = StaminaBar.new()

# Add the bars to the scene
add_child(health_bar)
add_child(stamina_bar)

# Update the health and stamina bars
health_bar.update_health(damage)
stamina_bar.update_stamina(usage)
