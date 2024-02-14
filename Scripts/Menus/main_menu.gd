extends CanvasLayer

@onready var main_scene: PackedScene = load("res://Scenes/dev_spawn.tscn")
@onready var color_rect: ColorRect = $CanvasLayer/ColorRect

var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready():
	if(tween != null):
		tween.kill()
	tween = create_tween()
	
	tween.tween_property(color_rect, "modulate:a", 0, 1)
	tween.tween_callback(func(): color_rect.visible = false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_scene():
	get_tree().change_scene_to_packed(main_scene)

func _on_start_game_button_pressed():
	if(tween != null):
		tween.kill()
	tween = create_tween()
	color_rect.visible = true
	tween.tween_property(color_rect, "modulate:a", 1, 1)
	tween.tween_callback(change_scene)


func _on_quit_button_pressed():
	get_tree().quit()
