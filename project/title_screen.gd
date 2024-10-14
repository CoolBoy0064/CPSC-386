extends Control





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Overworld.tscn")


func _on_quite_button_pressed() -> void:
	get_tree().quit()


#Code curtosy of Gwizz on youtube
func _on_volume_value_changed(value: float) -> void:
	if (value == 0):
		AudioServer.set_bus_mute(0, 1)
		return
	if (!AudioServer.get_bus_mute(0)):
		AudioServer.set_bus_mute(0, 0)
	var volume_change = value/10
	AudioServer.set_bus_volume_db(0, volume_change)


func _on_exit_settings_pressed() -> void:
	$SettingsMenu.hide()
	$MainMenu.show()


func _on_settings_pressed() -> void:
	$SettingsMenu.show()
	$MainMenu.hide()


func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2(3440, 1440))
		1:
			DisplayServer.window_set_size(Vector2(1920, 1080))
		2:
			DisplayServer.window_set_size(Vector2(1600, 900))
		3:
			DisplayServer.window_set_size(Vector2(1280, 720))
