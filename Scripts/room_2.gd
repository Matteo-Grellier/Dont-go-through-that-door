extends Node3D

@onready var lights = [$Light3, $Light2, $Light]

func _ready():
	start_room()

func start_room():
	for light in lights:
		await wait(1)
		light.swhitch_lights_on()
		


func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
