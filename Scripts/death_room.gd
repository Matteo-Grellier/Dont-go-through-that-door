extends Node3D

@onready var spot_light: SpotLight3D = $SpotLight3D


func start_death_room():
	await wait(2.0)
	spot_light.light_energy = 5
	# Play weird sound
	await wait(6)
	# Respawn


func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
