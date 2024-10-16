extends Control




func _on_continue_pressed() -> void:
	pass


func _on_save_and_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://title_screen.tscn") 
