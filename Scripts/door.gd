class_name Door
extends Node3D

var is_opened: bool = false

@onready var tween = get_tree().create_tween()

func open_door():
	is_opened = !is_opened
	
	print("CEST OPEN ?", is_opened)
	
	if tween != null:
		tween.kill()
		tween = get_tree().create_tween()
	
	tween.tween_property($DoorPanel, "rotation:y", deg_to_rad(90) if is_opened else 0, .8)
	
	if is_opened:
		tween.parallel().tween_property($DoorPanel/DoorHandle, "rotation:z", deg_to_rad(60), .3)
		tween.tween_property($DoorPanel/DoorHandle, "rotation:z", deg_to_rad(0), .3)
