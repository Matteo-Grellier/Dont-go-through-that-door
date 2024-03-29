class_name NeonLight

extends Node3D

signal light_is_on

@onready var omnis: Array[OmniLight3D] = [$light/OmniLight3D2, $light/OmniLight3D4, $light/OmniLight3D9, $light/OmniLight3D6, $light/OmniLight3D8, $light/OmniLight3D10]
@onready var sound: AudioStreamPlayer3D = $AudioStreamPlayer3D

func swhitch_lights_on(delay: float):
	await wait(delay)
	for omni: OmniLight3D in omnis:
		omni.light_energy = .35
	light_is_on.emit()
	sound.play()

func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
