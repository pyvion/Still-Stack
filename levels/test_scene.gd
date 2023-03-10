extends Node


func _ready():
	for child in get_children():
		var rec:RigidBody2D = child
		rec.input_pickable = true
		rec.connect("mouse_entered", self, "_on_entered")
		rec.connect("mouse_exited", self, "_on_exited")


func _process(delta):
	pass


func _physics_process(delta):
	pass

func _on_entered():
	print("enter")


func _on_exited():
	print("exit")
