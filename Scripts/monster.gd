extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	animate_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func animate_sprite():
	await wait(2)
	$AnimatedSprite3D.play("little_smile")
	await wait(2)
	$AnimatedSprite3D.play("smile")
	await wait(2)
	$AnimatedSprite3D.play("big_smile")
	await wait(2)
	$AnimatedSprite3D.play("huge_smile")

func wait(duration):  
	await get_tree().create_timer(duration, false, false, true).timeout
