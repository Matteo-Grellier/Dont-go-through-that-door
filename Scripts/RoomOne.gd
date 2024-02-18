extends Node3D

@onready var speaker = $Speaker

# Called when the node enters the scene tree for the first time.
func _ready():
	($SpotLight3D3 as SpotLight3D).light_energy = 0
	($SpotLight3D4 as SpotLight3D).light_energy = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# WARNING: This function is really important in Rooms Script
func start_room():
	($SpotLight3D4 as SpotLight3D).light_energy = 1
	($SpotLight3D3 as SpotLight3D).light_energy = 1
	($Light as NeonLight).swhitch_lights_on(3)

func trigger_sound():
	speaker.play_audio(0)


func _on_light_light_is_on():
	trigger_sound()
