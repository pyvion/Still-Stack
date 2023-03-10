extends Node


onready var Level

onready var background := $background
onready var block_preview := $block_preview
onready var queue_list := $QueueList
onready var level_node := $level
var active_block_list:Array

enum game_states {
	active,
	end_level_countdown,
	won,
	lost,
}
var current_game_state = game_states.active
var can_place_block = true


func _ready():
	Level = load(GameData.get_current_level())
	var instanced_level = Level.instance()
	
	# Play background music
	if GameData.music_player.stream != GameData.music[1]:
		GameData.music_player.stream = GameData.music[1]
		GameData.music_player.play()
	
	# Get static blocks
	for block in instanced_level.get_node("static").get_children():
		instanced_level.get_node("static").remove_child(block)
		level_node.get_node("static").add_child(block)
		block.mode = RigidBody2D.MODE_STATIC
		
		# Enable mouse over
		block.input_pickable = true
		block.connect("mouse_entered", self, "_on_StaticBlock_mouse_entered")
		block.connect("mouse_exited", self, "_on_StaticBlock_mouse_exited")

	
	# Get queue blocks
	for block in instanced_level.get_node("queue").get_children():
		instanced_level.get_node("queue").remove_child(block)
		active_block_list.append(block)
	
	# Add the blocks to the QueueList
	$QueueList.set_blocks(active_block_list)
	
	# Set preview
	_update_block_preview()


func _process(delta):
	# Display active block preview
	if current_game_state == game_states.active and can_place_block:
		block_preview.position = level_node.get_local_mouse_position()
	
	# Update the countdown timer
	if $UITimer.visible:
		$UITimer.value = $Timer.time_left


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		get_tree().change_scene("res://ui/LevelSelector.tscn")
	
	if current_game_state == game_states.active:		
		if Input.is_action_just_pressed("select") and can_place_block:
			# Place block
			var new_block = active_block_list.pop_front()
			if new_block != null:
				new_block.position = level_node.get_local_mouse_position()
				level_node.get_node("active").add_child(new_block)
				queue_list.remove_block()
				
				_update_block_preview()
				
				# Enable Mouse over
				new_block.input_pickable = true
				new_block.connect("mouse_entered", self, "_on_StaticBlock_mouse_entered")
				new_block.connect("mouse_exited", self, "_on_StaticBlock_mouse_exited")
				
				# Play sound effect
				GameData.sfx_player.stream = GameData.sound_effects[1]
				GameData.sfx_player.play()
				
				# Check for completion
				if active_block_list.size() == 0:
					current_game_state = game_states.end_level_countdown
					$Timer.start(5)
					$UITimer.visible = true
					
					# Play clock ticking
					GameData.sfx_player.stream = GameData.sound_effects[4]
					GameData.sfx_player.play()


func _update_block_preview():
	if active_block_list.size() > 0:
		block_preview.texture = active_block_list[0].get_node("Sprite").texture
		block_preview.scale = active_block_list[0].block_scale
		block_preview.rotation = active_block_list[0].rotation
	else:
		block_preview.texture = null


func _on_Timer_timeout():
	$UITimer.visible = false
	game_over(true)


func _on_OutOfBoundsArea2D_body_entered(body):
	current_game_state = game_states.lost
	$Timer.stop()
	$UITimer.visible = false
	game_over(false)


func win():
	pass


func lose():
	pass


func _on_HomeButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	
	get_tree().paused = false
	get_tree().change_scene("res://ui/MainMenu.tscn")


func _on_RepeatButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_NextLevelButton_pressed():
	GameData.sfx_player.stream = GameData.sound_effects[0]
	GameData.sfx_player.play()
	
	GameData.current_level_idx += 1
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_StaticBlock_mouse_entered():
	can_place_block = false
	block_preview.visible = false


func _on_StaticBlock_mouse_exited():
	can_place_block = true
	block_preview.visible = true


func game_over(is_win):
	if is_win:
		GameData.sfx_player.stream = GameData.sound_effects[2]
		GameData.sfx_player.play()
				
		if GameData.current_level_idx == GameData.completed_levels:
			GameData.completed_levels += 1
			GameData.save_to_disk()
	else:
		GameData.sfx_player.stream = GameData.sound_effects[3]
		GameData.sfx_player.play()
	get_tree().paused = true
	$CenterContainer/EndGamePanel/VBoxContainer/LostLabel.visible = not is_win
	$CenterContainer/EndGamePanel/VBoxContainer/WonLabel.visible = is_win
	$CenterContainer/EndGamePanel/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/RepeatButton.visible = not is_win
	$CenterContainer/EndGamePanel/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/NextLevelButton.visible = is_win
	$CenterContainer.visible = true
	
	# Last level
	if is_win and GameData.current_level_idx + 1 == GameData.level_paths.size():
		$CenterContainer/EndGamePanel/VBoxContainer/WonLabel.visible = false
		$CenterContainer/EndGamePanel/VBoxContainer/EndLabel.visible = true
		$CenterContainer/EndGamePanel/VBoxContainer/PanelContainer/VBoxContainer/HBoxContainer/NextLevelButton.visible = false
