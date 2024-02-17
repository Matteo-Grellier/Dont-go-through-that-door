extends Node3D

var door:Door

func _ready():
	door = $Door
	door.visible = false

func _on_timer_timeout():
	door.visible = true
