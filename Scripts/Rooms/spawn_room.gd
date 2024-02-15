extends Node3D

@onready var left_door := $LeftDoor
@onready var right_door := $RightDoor
@onready var speaker := $Speaker

# Called when the node enters the scene tree for the first time.
func _ready():
	left_door.is_good = true
	right_door.is_good = false
	speaker.play_audio(0)

func invert_correct_door():
	left_door.is_good = !left_door.is_good
	right_door.is_good = !right_door.is_good
	
	if left_door.is_good:
		speaker.play_audio(3)


func _on_speaker_audio_finished():
	if speaker.is_already_played:
		return
	
	if left_door.is_good:
		speaker.play_audio(1)
	elif right_door.is_good:
		speaker.play_audio(2)
	
	speaker.is_already_played = true
