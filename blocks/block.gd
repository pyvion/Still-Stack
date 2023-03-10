extends RigidBody2D

export var block_scale = Vector2.ONE setget set_block_scale

func _ready():
	pass
	

func set_block_scale(value):
	block_scale = value
	for child in self.get_children():
		child.scale = value
	
