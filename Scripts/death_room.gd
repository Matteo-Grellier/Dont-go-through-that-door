extends Node3D

@onready var spot_light: SpotLight3D = $SpotLight3D
@onready var game_manager: GameManager = get_node("/root/GameManager")
var monster = preload("res://Scenes/monster.tscn")
func start_room():
	$AudioStreamPlayer.playing = true
	await wait(3.0)
	spot_light.light_energy = 5
	var monster_instance = monster.instantiate()
	monster_instance.position = Vector3(monster_instance.position.x, monster_instance.position.y+1, monster_instance.position.z-9)
	add_child(monster_instance)
	# Play weird sound
	await wait(9)
	# Respawn
	game_manager.player.position = Vector3(0, 2, 0)
	remove_child(monster_instance)
	spot_light.light_energy = 0
	game_manager.unload_all_rooms()

func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
