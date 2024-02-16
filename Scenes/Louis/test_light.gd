extends Node3D

@onready var lights: Array[NeonLight] = [$Light, $Light2]

func _ready():
	for light in lights:
		light.swhitch_lights_on(2)
