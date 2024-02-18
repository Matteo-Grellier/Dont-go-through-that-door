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
var player : CharacterBody3D
func on_start():

	array_of_rooms_to_delete.clear()
	wait_two_rooms = 0
	if get_parent().get_node("GameScene"):
		player = preload("res://Scenes/Player.tscn").instantiate()
		get_parent().get_node("GameScene").add_child(player)
		
		room_behind_the_door = "SpawnRoom"
		get_all_doors_in_room()
		

func get_all_doors_in_room():
	room_node = get_node("../GameScene/"+room_behind_the_door)
	for i in room_node.get_child_count():
		if (room_node.get_child(i).is_in_group("Door")):
			var room_to_get = room_node.get_child(i).get("whats_behind_the_door")
			ResourceLoader.load_threaded_request("res://Scenes/Rooms/"+room_to_get+".tscn")

var door_node:Door

func load_map():
	var next_room_scene = ResourceLoader.load_threaded_get("res://Scenes/Rooms/"+room_behind_the_door+".tscn")
	if next_room_scene == null:
		printerr("The door has no defined room")
	else: 
		var next_room:Node3D = next_room_scene.instantiate()
		door_node.closed_behind.connect(_on_closed_behind)
		
		get_parent().get_node("GameScene").add_child(next_room)
		next_room.global_position = door_node.global_position
		next_room.rotation = door_node.global_rotation
		next_room.rotation
		array_of_rooms_to_delete.append(get_node("../GameScene/"+room_behind_the_door))

var wait_two_rooms:int = 0

func _on_closed_behind():
	cut_music()
	unload_last_room()
	
	var new_room_node = get_node("../GameScene/"+room_behind_the_door)
	if new_room_node.has_method("start_room"):
		new_room_node.start_room() # Call the start_room function in rooms script

func unload_last_room():
	if wait_two_rooms == 2:
		array_of_rooms_to_delete[0].queue_free()
		array_of_rooms_to_delete.pop_at(0)
	else :
		wait_two_rooms += 1

func cut_music():
	var tween = create_tween()
	tween.parallel().tween_property(player.get_node("AudioStreamPlayer"), "volume_db", 0, 3)
