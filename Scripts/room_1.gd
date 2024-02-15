extends Node3D

@onready var speaker = $Speaker

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation.y = deg_to_rad(90)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func trigger_sound():
	speaker.play_audio(0)
