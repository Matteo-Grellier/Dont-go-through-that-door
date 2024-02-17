extends Node3D

@export var is_ended = false

@onready var speaker = $Speaker


# Called when the node enters the scene tree for the first time.
func _ready():
	($SpotLight3D3 as SpotLight3D).light_energy = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_ended:
		get_tree().quit()

# WARNING: This function is really important in Rooms Script
func start_room():
	($Light as NeonLight).swhitch_lights_on(3)

func trigger_sound():
	speaker.play_audio(0)


func _on_light_light_is_on():
	($SpotLight3D3 as SpotLight3D).light_energy = 1
	trigger_sound()


func _on_final_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.current_animation = "the end"
