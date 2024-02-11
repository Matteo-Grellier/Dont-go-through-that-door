class_name Door
extends Node3D

@export var default_color := Color(0.44, 0.26, 0.12)

var is_opened: bool = false
var is_looked_at: bool = false

var material_to_change_color = StandardMaterial3D.new()

#@onready var tween = get_tree().create_tween()
var tween

func _ready():
	set_color(default_color)

func _process(_delta):
	if is_looked_at:
		var new_color = Color(default_color.r+0.2, default_color.g+0.2, default_color.b+0.2)
		set_color(new_color)
	else:
		set_color(default_color)

func set_color(color: Color):
	material_to_change_color.albedo_color = color
	($DoorPanel/PanelMesh as MeshInstance3D).material_override = material_to_change_color

func open_door():
	is_opened = !is_opened
	
	if tween != null:
		tween.kill()
	
	tween = get_tree().create_tween()
	
	tween.tween_property($DoorPanel, "rotation:y", deg_to_rad(90) if is_opened else 0, .8)
	
	if is_opened:
		tween.parallel().tween_property($DoorPanel/DoorHandle, "rotation:z", deg_to_rad(60), .3)
		tween.tween_property($DoorPanel/DoorHandle, "rotation:z", deg_to_rad(0), .3)
