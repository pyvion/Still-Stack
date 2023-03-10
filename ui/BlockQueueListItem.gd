extends Control


func _ready():
	pass

func initialize(block):
	var size = block.get_node("Sprite").texture.get_size() * block.block_scale
	var texture = block.get_node("Sprite").texture
	$BlockQueueListItem/HBoxContainer/PanelContainer/Control/TextureRect.texture = texture
	$BlockQueueListItem/HBoxContainer/Label.text = "{width} * {height}".format({"width":int(size.x),"height":int(size.y)})
	$BlockQueueListItem/HBoxContainer/PanelContainer/Control/TextureRect.rect_rotation = block.rotation_degrees
