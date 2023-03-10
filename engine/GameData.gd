extends Node

var music_player
var sfx_player

const music = [
	preload("res://assets/music/Juhani Junkala [Chiptune Adventures] 1. Stage 1.ogg"),
	preload("res://assets/music/Juhani Junkala [Chiptune Adventures] 2. Stage 2.ogg"),
	preload("res://assets/music/Juhani Junkala [Chiptune Adventures] 4. Stage Select.ogg"),
]

const sound_effects = [
	preload("res://assets/sound_effects/click_4.ogg"),
	preload("res://assets/sound_effects/click_2.ogg"),
	preload("res://assets/sound_effects/ding_deep.ogg"),
	preload("res://assets/sound_effects/negative_sound_volumefixed.ogg"),
	preload("res://assets/sound_effects/clock-1_volumefixed.ogg"),
]

var level_paths = [
	"res://levels/level_01.tscn", 
	"res://levels/level_02.tscn", 
	"res://levels/level_03.tscn", 
	"res://levels/level_04.tscn",
	
	"res://levels/level_05.tscn",
	"res://levels/level_06.tscn", 
	"res://levels/level_07.tscn", 
	"res://levels/level_08.tscn",
	
	"res://levels/level_09.tscn", 
	"res://levels/level_10.tscn",
	"res://levels/level_11.tscn", 
	"res://levels/level_12.tscn", 
]

var completed_levels = 0
var current_level_idx = 0

func _ready():
	# Setup music player
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	music_player.stream = music[0]
	music_player.pause_mode = Node.PAUSE_MODE_PROCESS
	music_player.play()
	
	# Setup sound effect player
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	sfx_player.pause_mode = PAUSE_MODE_PROCESS
	
	
	load_from_disk()
	#save_to_disk()

func save_to_disk():
	var file = File.new()
	file.open("user://save_game.dat", File.WRITE)
	
	file.store_64(completed_levels)
	
	file.close()


func load_from_disk():
	var file = File.new()
	var error_code = file.open("user://save_game.dat", File.READ)
	
	if error_code != OK:
		return
	
	completed_levels = file.get_64()
	
	file.close()


func reset_progress():
	completed_levels = 0
	current_level_idx = 0
	save_to_disk()
	

func get_current_level():
	return level_paths[current_level_idx]
