extends CanvasLayer

@onready var main_scene: PackedScene = load("res://Scenes/Mattéo/GameScene.tscn")
@onready var color_rect: ColorRect = $Control/ColorRect
@onready var options := $Control/MainMenuContent/Options
@onready var menu_buttons := $Control/MainMenuContent/MenuButtons

@onready var clic_sound: AudioStreamPlayer = $ClicSound
@onready var tap_sound: AudioStreamPlayer = $TapSound

var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if(tween != null):
		tween.kill()
	tween = create_tween()
	
	tween.tween_property(color_rect, "modulate:a", 0, 1)
	tween.tween_callback(func(): color_rect.visible = false)

func change_scene():
	get_tree().change_scene_to_packed(main_scene)

func _on_start_game_button_pressed():
	clic_sound.play()
	if(tween != null):
		tween.kill()
	tween = create_tween()
	color_rect.visible = true
	tween.tween_property(color_rect, "modulate:a", 1, 2)
	tween.parallel().tween_property($AudioStreamPlayer, "volume_db", -20, 2)
	tween.tween_callback(change_scene)

func _on_options_button_pressed():
	clic_sound.play()
	options.visible = true
	menu_buttons.visible = false

func _on_quit_button_pressed():
	clic_sound.play()
	get_tree().quit()

func _on_options_go_back():
	clic_sound.play()
	options.visible = false
	menu_buttons.visible = true


func _on_start_game_button_mouse_entered():
	tap_sound.play()

func _on_options_button_mouse_entered():
	tap_sound.play()

func _on_quit_button_mouse_entered():
	tap_sound.play()


func _on_options_mouse_on_go_back():
	tap_sound.play()
