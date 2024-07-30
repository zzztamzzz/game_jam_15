extends Node2D

@onready var pause_menu = $Player/PauseMenu
var paused = false

func _process(delta):
	$ShadowOrb.play("default")
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused

func _on_area_2d_area_entered(area):
	get_tree().change_scene_to_file("res://Scenes/ui/game_over.tscn")
