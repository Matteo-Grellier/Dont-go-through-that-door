extends Node3D

@onready var spots: Array[SpotLight3D] = [$light/OmniLight3D, $light/OmniLight3D3, $light/OmniLight3D5, $light/OmniLight3D7]
@onready var omnis: Array[OmniLight3D] = [$light/OmniLight3D2, $light/OmniLight3D4, $light/OmniLight3D9, $light/OmniLight3D6, $light/OmniLight3D8, $light/OmniLight3D10]

func swhitch_lights_on():
	for spot: SpotLight3D in spots:
		spot.light_energy = 5
	for omni: OmniLight3D in omnis:
		omni.light_energy = 1
