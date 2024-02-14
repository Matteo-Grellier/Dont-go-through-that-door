extends Node

var index:int=0
var room_to_delete : Node3D
func _ready():
	var timer = get_node("../GameScene/Timer")
	if (!timer ==null):
		timer.timeout.connect(_on_timer_timeout)
	var dir = DirAccess.open("res://Scenes/Rooms")
	var player = preload("res://Scenes/Player.tscn").instantiate()
	get_parent().get_node("GameScene").add_child(player)
	ResourceLoader.load_threaded_request("res://Scenes/Rooms/Room2.tscn")
	room_behind_the_door = "Room2"
	room_node = get_node("../GameScene/devSpawn")
	room_to_delete = room_node

var pourcentageArray = []
var room_behind_the_door: String
func _on_timer_timeout():
	ResourceLoader.load_threaded_get_status("res://Scenes/Rooms/"+room_behind_the_door+".tscn", pourcentageArray)
	#print("res://Scenes/Rooms/"+room_behind_the_door+".tscn")
	#print(pourcentageArray)
var room_node:Node3D
func get_all_doors_in_room(room_name:String):
	room_node = get_node("../GameScene/"+room_name)
	for i in room_node.get_child_count():
		if (room_node.get_child(i).is_in_group("Door")):
			var door:Node3D = room_node.get_child(i)
			room_behind_the_door = door.get("whats_behind_the_door")
			ResourceLoader.load_threaded_request("res://Scenes/Rooms/"+room_behind_the_door+".tscn")

var door_node:Door
func load_map():
	print()
	var next_room_scene = ResourceLoader.load_threaded_get("res://Scenes/Rooms/"+room_behind_the_door+".tscn")
	print(next_room_scene)
	var next_room:Node3D = next_room_scene.instantiate()
	door_node.closed_behind.connect(door_is_closed)
	next_room.global_position = door_node.global_position
	get_parent().get_node("GameScene").add_child(next_room)

var map_to_unload:Node3D
var wait_one_door:bool = false
func door_is_closed():
	if wait_one_door:
		room_to_delete.queue_free()
		room_to_delete = get_node("../GameScene/"+room_behind_the_door)
	wait_one_door = true
