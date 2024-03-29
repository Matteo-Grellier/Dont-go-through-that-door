extends Node3D

@onready var speaker = $Speaker

var is_already_played: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# WARNING: This function is really important in Rooms Script
func start_room():
	($Light as NeonLight).swhitch_lights_on(2)
	($Light2 as NeonLight).swhitch_lights_on(3)
	($Light3 as NeonLight).swhitch_lights_on(4)
	($Light4 as NeonLight).swhitch_lights_on(5)
	($Light5 as NeonLight).swhitch_lights_on(6)
	
	await wait(2)
	($SpotLight3D4 as SpotLight3D).light_energy = 1
	($SpotLight3D3 as SpotLight3D).light_energy = 1


func trigger_sound():
	speaker.play_audio(0)

func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout

func _on_light_light_is_on():
	if is_already_played:
		return
	
	trigger_sound()
	is_already_played = true
