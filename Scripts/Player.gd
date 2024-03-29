extends CharacterBody3D

const speed: float = 5.0
const jumpVelocity: float = 4.5

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var sensitivity: float = 0.001

@onready var neck:Node3D = $Neck
@onready var walk_sound: AudioStreamPlayer = $walk
@onready var camera:Camera3D = $Neck/Camera3D

func _ready():
	var tween = create_tween()
	tween.parallel().tween_property($AudioStreamPlayer, "volume_db", 0, 3)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * sensitivity)
			camera.rotate_x(-event.relative.y * sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jumpVelocity

	var inputDir: Vector2 = Input.get_vector("left", "right", "forward", "back")
	var direction: Vector3 = (neck.transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if !walk_sound.playing:
			walk_sound.play()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		if walk_sound.playing:
			walk_sound.stop()

	move_and_slide()
