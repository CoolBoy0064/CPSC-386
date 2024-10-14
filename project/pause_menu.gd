extends Control


# Called when the node enters the scene tree for the first time.


func _on_quit_game_pressed() -> void:
	if(get_tree().paused):
		get_tree().paused = false
	get_tree().change_scene_to_file("res://title_screen.tscn")
	#ADD CODE HERE TO SAVE THE GAME


func _on_resume_pressed() -> void:
	if(get_tree().paused):
		get_tree().paused = false
	if (get_parent().has_method("pause")):
		get_parent().pause()
