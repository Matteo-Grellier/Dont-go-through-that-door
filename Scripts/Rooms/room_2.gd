extends Node3D

@onready var light_back: NeonLight = $Light
@onready var light_back2: NeonLight = $Light3
@onready var light_front: NeonLight = $Light2
@onready var light_front2: NeonLight = $Light4
@onready var speaker = $Speaker

var is_already_played = false

func _ready():
	start_room()

func start_room():
	light_front.swhitch_lights_on(2)
	light_front2.swhitch_lights_on(2)
	light_back.swhitch_lights_on(4)
	light_back2.swhitch_lights_on(4)


func _on_light_light_is_on():
	
	if is_already_played:
		return
	
	await wait(1)
	speaker.play_audio(0)
	is_already_played = true


func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
