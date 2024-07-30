extends Node2D

var pause_menu

func _ready():
	# Replace "PauseMenu" with your actual pause menu scene path
	pause_menu = preload("res://Scenes/ui/pause_menu.tscn").instantiate()
	add_child(pause_menu)
	pause_menu.hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):  # Assuming "ui_cancel" is mapped to the ESC key
		toggle_pause()

func _on_pause_pressed():
	toggle_pause()

func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		pause_menu.hide()
	else:
		get_tree().paused = true
		pause_menu.show()
