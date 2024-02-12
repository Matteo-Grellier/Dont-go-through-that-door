extends Node

var index:int=0

# Called when the node enters the scene tree for the first time.
func _ready():
	var dir = DirAccess.open("res://Scenes/Rooms")
	var player = preload("res://Scenes/Player.tscn").instantiate()
	add_child(player)
	var room1 = preload("res://Scenes/Rooms/Room 1.tscn").instantiate()
	add_child(room1)
	var room2 = preload("res://Scenes/Rooms/Room 2.tscn").instantiate()
	add_child(room2)
	# Si la porte n'est pas au milieu ca marche pas.
	room2.position = Vector3(0,0,-20)
	

func _on_opened_door():
	index+1
	if (!index == 1):
		var next_room_scene = ResourceLoader.load_threaded_get("Room à afficher")
		var next_room = next_room_scene.instantiate()
		add_child(next_room)
		next_room.position = Vector3(0,0,-40)
		

# la porte lance la fonction à sa fermeture
func _on_closed_door():
	# indenter la room suivante
	ResourceLoader.load_threaded_request("room d'après")
	get_node("Room3").queue_free()
	
