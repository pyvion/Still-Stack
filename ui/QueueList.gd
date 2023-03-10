extends PanelContainer

onready var BlockQueueListItem = preload("res://ui/BlockQueueListItem.tscn")

func _ready():
	pass

func clear():
	for node in $ScrollContainer/VBoxContainer.get_children():
		$ScrollContainer/VBoxContainer.remove_child(node)
		node.queue_free()

func set_blocks(blocks):
	self.clear()
	for block in blocks:
		var list_item = BlockQueueListItem.instance()
		list_item.initialize(block)
		$ScrollContainer/VBoxContainer.add_child(list_item)
	
func remove_block():
	$ScrollContainer/VBoxContainer.remove_child($ScrollContainer/VBoxContainer.get_child(0))
