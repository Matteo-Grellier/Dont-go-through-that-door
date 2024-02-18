extends Control

@onready var main_menu_scene: PackedScene = load("res://Scenes/Menus/main_menu.tscn")
@onready var option_menu: VBoxContainer = $Options
@onready var pause_menu_buttons: VBoxContainer = $PauseMenuButtons
@onready var game_manager: GameManager = get_node("/root/GameManager")

@onready var tap_sound: AudioStreamPlayer = $TapSound
@onready var clic_sound: AudioStreamPlayer = $clic

var is_pause_menu_enabled = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		change_menu_state()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_menu_state():
	is_pause_menu_enabled = !is_pause_menu_enabled
	
	if is_pause_menu_enabled:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		visible = true
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		get_tree().paused = false
		visible = false


func _on_resume_button_pressed():
	clic_sound.play()
	change_menu_state()


func _on_options_pressed():
	clic_sound.play()
	option_menu.visible = true
	pause_menu_buttons.visible = false


func _on_quit_button_pressed():
	clic_sound.play()
	game_manager.set("not_even_in_game_scene", false)
	change_menu_state()
	get_tree().change_scene_to_packed(main_menu_scene)


func _on_options_go_back():
	clic_sound.play()
	option_menu.visible = false
	pause_menu_buttons.visible = true




func _on_resume_button_mouse_entered():
	tap_sound.play()

func _on_options_mouse_entered():
	tap_sound.play()

func _on_quit_button_mouse_entered():
	tap_sound.play()


func _on_options_mouse_on_go_back():
	tap_sound.play()
