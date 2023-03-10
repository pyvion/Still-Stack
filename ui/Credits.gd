extends Control

const licence_text = """
[url="https://www.kenney.nl/assets/rolling-ball-assets"]"Rolling Ball Assets"[/url] by [url="https://www.kenney.nl"]Kenney[/url], licenced under [url="https://creativecommons.org/publicdomain/zero/1.0/"]CC0[/url]
[url="https://www.kenney.nl/assets/game-icons"]"Game Icons"[/url] by [url="https://www.kenney.nl"]Kenney[/url], licenced under [url="https://creativecommons.org/publicdomain/zero/1.0/"]CC0[/url]
[url="https://www.kenney.nl/assets/ui-pack"]"UI Pack"[/url] by [url="https://www.kenney.nl"]Kenney[/url], licenced under [url="https://creativecommons.org/publicdomain/zero/1.0/"]CC0[/url]
[url="https://opengameart.org/content/4-chiptunes-adventure"]"4 Chiptunes (Adventure)"[/url] by [url="https://juhanijunkala.com/"]Juhani Junkala[/url], licenced under [url="https://creativecommons.org/publicdomain/zero/1.0/"]CC0[/url]
[url="https://opengameart.org/content/ui-sound-effects-button-clicks-user-feedback-notifications"]"UI Sound Effects (Button Clicks, User Feedback, Notifications)"[/url], licenced under [url="https://creativecommons.org/publicdomain/zero/1.0/"]CC0[/url]
[url="https://opengameart.org/content/ticking-clock-0"]"Ticking Clock" by [url="https://opengameart.org/users/antumdeluge"]Jordan Irwin[/url], licenced under [url="https://creativecommons.org/publicdomain/zero/1.0/"]CC0[/url]
"""

func _ready():
	# Play background music
	if GameData.music_player.stream != GameData.music[2]:
		GameData.music_player.stream = GameData.music[2]
		GameData.music_player.play()
	
	# Setup text
	var base_text = "[center][b]Made by:[/b]\nPyvion\n\n[b]Assets used:[/b]{}[center]\n\n"
	var full_text = base_text.format([licence_text], "{}")
	$MarginContainer/VBoxContainer/PanelContainer/RichTextLabel.bbcode_text = full_text


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		get_tree().change_scene("res://ui/MainMenu.tscn")
		

func _on_RichTextLabel_meta_clicked(meta):
	OS.shell_open(str(meta))


func _on_ReturnButton_pressed():
	get_tree().change_scene("res://ui/MainMenu.tscn")
