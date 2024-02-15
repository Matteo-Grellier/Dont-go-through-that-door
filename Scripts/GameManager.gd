extends Node

var not_even_in_game_scene:bool = false
func _process(delta: float) -> void:
	
	if get_tree().current_scene != null:
		if (get_tree().current_scene.name == "GameScene" && !not_even_in_game_scene):
			not_even_in_game_scene = true
			on_start()

var array_of_rooms_to_delete:Array[Node3D]
var room_behind_the_door: String
var room_node:Node3D

func on_start():
	print("TEST")
	if get_parent().get_node("GameScene"):
		
		get_parent().get_node("GameScene").add_child(preload("res://Scenes/Player.tscn").instantiate())
	
		ResourceLoader.load_threaded_request("res://Scenes/Rooms/Room2.tscn")
		room_behind_the_door = "Room2"
		room_node = get_node("../GameScene/devSpawn")
		array_of_rooms_to_delete.append(room_node)

func get_all_doors_in_room(room_name:String):
	room_node = get_node("../GameScene/"+room_name)
	for i in room_node.get_child_count():
		if (room_node.get_child(i).is_in_group("Door")):
			room_behind_the_door = room_node.get_child(i).get("whats_behind_the_door")
			ResourceLoader.load_threaded_request("res://Scenes/Rooms/"+room_behind_the_door+".tscn")

var door_node:Door

func load_map():
	var next_room_scene = ResourceLoader.load_threaded_get("res://Scenes/Rooms/"+room_behind_the_door+".tscn")
	var next_room:Node3D = next_room_scene.instantiate()
	
	door_node.closed_behind.connect(unload_last_room)
	get_parent().get_node("GameScene").add_child(next_room)
	next_room.global_position = door_node.global_position
	array_of_rooms_to_delete.append(get_node("../GameScene/"+room_behind_the_door))

var wait_one_door:bool = false

func unload_last_room():
	if wait_one_door:
		array_of_rooms_to_delete[0].queue_free()
		array_of_rooms_to_delete.pop_at(0)
	wait_one_door = true
