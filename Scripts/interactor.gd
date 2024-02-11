extends RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#add_exception(owner)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_colliding():
		
		var collider = get_collider() as Node3D
		
		if collider.is_in_group("Interactable") and Input.is_action_just_pressed("interact"):
			interact_with_object(collider)
		

func interact_with_object(collider: Node3D):
	if(collider.owner is Door):
		collider.owner.open_door()
