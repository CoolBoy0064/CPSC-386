extends Control


# Called when the node enters the scene tree for the first time.


func _on_quit_game_pressed() -> void:
	if(get_tree().paused):
		get_tree().paused = false
	saveGameHere()
	get_tree().change_scene_to_file("res://title_screen.tscn")
	#ADD CODE HERE TO SAVE THE GAME


func _on_resume_pressed() -> void:
	if(get_tree().paused):
		get_tree().paused = false
	if (get_parent().has_method("pause")):
		get_parent().pause()

func saveGameHere():
	SaveGame.loadScene = load(get_tree().current_scene.scene_file_path)
# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
