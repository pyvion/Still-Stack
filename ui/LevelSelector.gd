extends Control

const LevelSelectorItem = preload("res://ui/LevelSelectorItem.tscn")
var level_data

onready var LevelGridContainer = $MarginContainer/VBoxContainer/CenterContainer/PanelContainer/VBoxContainer/PanelContainer/GridContainer

func _ready():
	# Play background music
	if GameData.music_player.stream != GameData.music[0]:
		GameData.music_player.stream = GameData.music[0]
		GameData.music_player.play()
	
	# Create a button for each level
	var counter := 0
	for level_path in GameData.level_paths:
		var level_button = LevelSelectorItem.instance()
		LevelGridContainer.add_child(level_button)
		level_button.connect("pressed", self, "_on_LevelButton_pressed", [counter])
		
		var is_available = counter <= GameData.completed_levels
		level_button.initialize(str(counter+1), is_available)
		counter += 1


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://ui/MainMenu.tscn")


func _on_LevelButton_pressed(id):
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	
	GameData.current_level_idx = id
	get_tree().change_scene("res://engine/gameplay_handler.tscn")


func _on_ReturnButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	
	get_tree().change_scene("res://ui/MainMenu.tscn")
