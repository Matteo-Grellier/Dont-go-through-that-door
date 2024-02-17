class_name Door
extends Node3D

@export var default_color := Color(0.44, 0.26, 0.12)
@export var whats_behind_the_door: String = ""
@export var door_text: String
@export var is_good := false


@onready var sound_open: AudioStreamPlayer3D = $AudioOpen
@onready var sound_close: AudioStreamPlayer3D = $AudioClose
@onready var game_manager: GameManager = get_node("/root/GameManager")
@onready var door_text_mesh_instance: MeshInstance3D = $DoorPanel/DoorText

signal closing_behind
signal closed_behind

var is_opened: bool = false
var is_looked_at: bool = false
var is_closed_behind: bool = false
var has_been_already_open:bool = false

var material_to_change_color = StandardMaterial3D.new()

var tween

func _ready():
	set_color(default_color)
	var door_text_mesh = (door_text_mesh_instance.mesh as TextMesh)
	door_text_mesh.text = door_text

func _process(_delta):
	if is_looked_at:
		game_manager.set("door_node",self)
		var new_color = Color(default_color.r+0.2, default_color.g+0.2, default_color.b+0.2)
		set_color(new_color)
	else:
		set_color(default_color)

func set_color(color: Color):
	material_to_change_color.albedo_color = color
	($DoorPanel/PanelMesh as MeshInstance3D).material_override = material_to_change_color

func change_door_state():
	is_opened = !is_opened

	if is_opened:
		open_door()
	else:
		close_door()

var room_node:Node3D
func open_door():
	if !has_been_already_open:
		game_manager.set("room_behind_the_door",whats_behind_the_door)
		game_manager.load_map()
		game_manager.get_all_doors_in_room()
	has_been_already_open = true
	
	sound_open.play()
	
	if tween != null:
		tween.kill()
	
	tween = get_tree().create_tween()
	
	tween.tween_property($DoorPanel, "rotation:y", deg_to_rad(90), .8)
	
	tween.parallel().tween_property($DoorPanel/DoorHandle, "rotation:z", deg_to_rad(60), .3)
	tween.tween_property($DoorPanel/DoorHandle, "rotation:z", deg_to_rad(0), .3)

func close_door():
	if tween != null:
		tween.kill()
	
	sound_close.play()
	
	tween = get_tree().create_tween()
	
	tween.tween_property($DoorPanel, "rotation:y", 0, .8)
	tween.parallel().tween_property($DoorPanel/DoorHandle, "rotation:z", deg_to_rad(0), .3)
	
	if is_closed_behind:
		tween.tween_callback(func(): closed_behind.emit())

func _on_area_3d_body_entered(body: Node3D):
	if(is_closed_behind): 
		return
	
	if(body.is_in_group("Player")):
		is_closed_behind = true
		close_door()
		closing_behind.emit()
	
