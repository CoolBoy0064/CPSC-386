extends Control




func _on_continue_pressed() -> void:
	pass # PUT CODE TO LOAD THE LATEST SAVED GAME


func _on_save_and_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn") #We can ONLY ever go back to the title screen and no other files
	#Add code to save the game here
