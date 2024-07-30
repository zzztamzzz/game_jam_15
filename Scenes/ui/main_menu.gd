extends Control

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/Main_Scene.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_instructions_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/ui/instructions.tscn")
