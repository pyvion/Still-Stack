extends Control

const LevelSelector = preload("res://ui/LevelSelector.tscn")
const CreditsScene = preload("res://ui/Credits.tscn")
const OptionsScene = preload("res://ui/OptionsMenu.tscn")


func _ready():
	# Play background music
	if GameData.music_player.stream != GameData.music[0]:
		GameData.music_player.stream = GameData.music[0]
		GameData.music_player.play()


func _on_StartButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	get_tree().change_scene_to(LevelSelector)


func _on_ExitButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	get_tree().quit()


func _on_OptionsButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	get_tree().change_scene_to(OptionsScene)


func _on_CreditsButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	get_tree().change_scene_to(CreditsScene)
