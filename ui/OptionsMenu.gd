extends Control


func _ready():
	# Load settings
	$"%FullscreenCheckBox".pressed = OS.window_fullscreen


func _on_FullscreenCheckBox_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_ReturnButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	get_tree().change_scene("res://ui/MainMenu.tscn")


func _on_MasterVolumeSlider_value_changed(value):
	$"%MasterVolumeLabel".text = str(value)


func _on_MusicVolumeSlider_value_changed(value):
	$"%MusicVolumeLabel".text = str(value)


func _on_SoundEffectsVolumeSlider_value_changed(value):
	$"%SoundEffectsVolumeLabel".text = str(value)


func _on_ResetProgressButton_pressed():
	GameData.reset_progress()
