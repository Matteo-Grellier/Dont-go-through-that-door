extends Node3D

var door:Door

func _ready():
	door = $Door
	door.visible = false
	($Walls/CSGCombiner3D/CSGBox3D8 as CSGBox3D).visible = false

func _on_timer_timeout():
	door.visible = true
	($Walls/CSGCombiner3D/CSGBox3D8 as CSGBox3D).visible = true

func start_room():
	($Light as NeonLight).swhitch_lights_on(1)
	($Light2 as NeonLight).swhitch_lights_on(3)
	($Light3 as NeonLight).swhitch_lights_on(5)
	($Light4 as NeonLight).swhitch_lights_on(6)
	($Light5 as NeonLight).swhitch_lights_on(8)
	($Light6 as NeonLight).swhitch_lights_on(10)
	($Light7 as NeonLight).swhitch_lights_on(12)
	($Light8 as NeonLight).swhitch_lights_on(14)
	($Light9 as NeonLight).swhitch_lights_on(16)
	($Light10 as NeonLight).swhitch_lights_on(18)

func trigger_sound():
	$Speaker.play_audio(0)
	$Speaker2.play_audio(0)
	$Speaker3.play_audio(0)
func _on_light_10_light_is_on():
	trigger_sound()
