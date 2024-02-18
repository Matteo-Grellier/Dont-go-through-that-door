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
	
	speaker.play_audio(1)
	
	speaker.is_already_played = true


func _on_area_3d_body_entered(body):
	if !body.is_in_group("Player"):
		return
	
	($LeftDoor as Door).is_closed_behind = false
	($RightDoor as Door).is_closed_behind = false
	($LeftDoor as Door).has_been_already_open = false
	($RightDoor as Door).has_been_already_open = false
	
	if speaker.is_already_played:
		speaker.play_audio(3)
	
	speaker.is_already_played = false
