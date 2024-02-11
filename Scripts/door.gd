class_name Door
extends Node3D

var is_opened: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_door():
	is_opened = !is_opened
	
	print("CEST OPEN ?", is_opened)
