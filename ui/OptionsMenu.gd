extends Control


func _ready():
	# Load settings
	$"%FullscreenCheckBox".pressed = OS.window_fullscreen
	$"%MasterVolumeSlider".value = GameData.master_volume
	$"%MusicVolumeSlider".value = GameData.music_volume
	$"%SoundEffectsVolumeSlider".value = GameData.sound_effects_volume
	
	$"%MasterVolumeLabel".text = str(GameData.master_volume * 100)
	$"%MusicVolumeLabel".text = str(GameData.music_volume * 100)
	$"%SoundEffectsVolumeLabel".text = str(GameData.sound_effects_volume * 100)


func _on_FullscreenCheckBox_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	GameData.save_config()


func _on_ReturnButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	get_tree().change_scene("res://ui/MainMenu.tscn")


func _on_MasterVolumeSlider_value_changed(value):
	$"%MasterVolumeLabel".text = str(value * 100)
	GameData.master_volume = value
	GameData.save_config()
	GameData.set_master_volume()


func _on_MusicVolumeSlider_value_changed(value):
	$"%MusicVolumeLabel".text = str(value * 100)
	GameData.music_volume = value
	GameData.save_config()
	GameData.set_music_volume()


func _on_SoundEffectsVolumeSlider_value_changed(value):
	$"%SoundEffectsVolumeLabel".text = str(value * 100)
	GameData.sound_effects_volume = value
	GameData.save_config()
	GameData.set_sound_effects_volume()


func _on_ResetProgressButton_pressed():
	GameData.reset_progress()


func _on_SoundEffectsVolumeSlider_drag_ended(value_changed):
	GameData.sfx_player.stream = GameData.sound_effects[1]
	GameData.sfx_player.play()
