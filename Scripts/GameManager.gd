extends Node

var index:int=0
var room_node: Node3D

# Called when the node enters the scene tree for the first time.


func _ready():
	var timer = get_node("../GameScene/Timer")
	timer.timeout.connect(_on_timer_timeout)
	var dir = DirAccess.open("res://Scenes/Rooms")
	var player = preload("res://Scenes/Player.tscn").instantiate()
	add_child(player)
	var room1 = preload("res://Scenes/Rooms/Room 1.tscn").instantiate()
	add_child(room1)
	var room2 = preload("res://Scenes/Rooms/Room 2.tscn").instantiate()
	add_child(room2)
	# Si la porte n'est pas au milieu ca marche pas.
	room2.position = Vector3(0,0,-20)

var pourcentageArray = []
var room_behind_the_door: String

func _on_timer_timeout():
	ResourceLoader.load_threaded_get_status("res://Scenes/Rooms/"+room_behind_the_door+".tscn", pourcentageArray)
	print("res://Scenes/Rooms/"+room_behind_the_door+".tscn")
	print(pourcentageArray)

func get_all_doors_in_room():
	for i in room_node.get_child_count():
		if (room_node.get_child(i).is_in_group("Door")):
			var door:Node3D = room_node.get_child(i)
			room_behind_the_door = door.get("whats_behind_the_door")
			ResourceLoader.load_threaded_request("res://Scenes/Rooms/"+room_behind_the_door+".tscn")
			#print("room : "+room_behind_the_door)
			
var has_a_room_load:bool = false
func load_map():
	var next_room_scene = ResourceLoader.load_threaded_get("res://Scenes/Rooms/"+room_behind_the_door+".tscn")
	var next_room = next_room_scene.instantiate()
	add_child(next_room)
