extends RayCast3D

var object_currently_viewed: Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_colliding():
		var collider = get_collider() as Node3D
		
		if collider.is_in_group("Interactable") and collider.owner is Door:
			if(collider.owner.is_closed_behind):
				return;
			
			(collider.owner as Door).is_looked_at = true
			
			object_currently_viewed = collider
			
			if Input.is_action_just_pressed("interact"):
				interact_with_door(collider.owner)
			
	elif object_currently_viewed != null and object_currently_viewed.owner is Door:
		(object_currently_viewed.owner as Door).is_looked_at = false

func interact_with_door(door: Door):
	door.change_door_state()
