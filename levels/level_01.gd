extends Node

onready var BallSmall = preload("res://blocks/BallSmall.tscn")
onready var BlockCorner = preload("res://blocks/BlockCorner.tscn")
onready var Blocknarrow = preload("res://blocks/BlockNarrow.tscn")

onready var block_preview = $block_preview
onready var static_objects = $static

func _ready():
	pass


func _process(delta):
	block_preview.position = static_objects.get_local_mouse_position()


func _physics_process(delta):
	if Input.is_action_just_pressed("select"):
		#var new_block = BallSmall.instance()
		var new_block = BlockCorner.instance()
		new_block.position = static_objects.get_local_mouse_position()
		static_objects.add_child(new_block)
