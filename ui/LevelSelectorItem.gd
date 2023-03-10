extends Button

const completed_texture_normal = preload("res://assets/ui/green_button09.png")
const completed_texture_pressed = preload("res://assets/ui/green_button10.png")
const notcompleted_texture_normal = preload("res://assets/ui/grey_button10.png")
const notcompleted_texture_pressed = preload("res://assets/ui/grey_button11.png")

func _ready():
	pass


func initialize(name, is_available):
	text = name
	$TextureRect.visible = not is_available
	if not is_available:
		#set("custom_styles/normal", preload("res://ui/LevelSelectorItemNomal.stylebox"))
		text = ""
		disabled = true
		mouse_default_cursor_shape = Control.CURSOR_ARROW
		
