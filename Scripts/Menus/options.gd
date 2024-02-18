extends VBoxContainer

signal go_back
signal mouse_on_go_back

@onready var sensitivity_slider: HSlider = $Sliders/SensitivitySlider
@onready var sound_slider: HSlider = $Sliders/SoundSlider
@onready var game_manager: GameManager = get_node("/root/GameManager")

var sound_effect_bus = AudioServer.get_bus_index("Sound")
var music_bus = AudioServer.get_bus_index("Music")
var narrator_bus = AudioServer.get_bus_index("Narrator")

func _ready():
	# Get value from GameManager and set default values for sliders
	$Sliders/NarratorVoiceSlider.value = db_to_linear(AudioServer.get_bus_volume_db(narrator_bus))
	$Sliders/MusicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	$Sliders/SoundSlider.value = db_to_linear(AudioServer.get_bus_volume_db(sound_effect_bus))
	
func _on_go_back_button_pressed():
	go_back.emit()

func _on_go_back_button_mouse_entered():
	mouse_on_go_back.emit()
  
func _on_music_slider_value_changed(value):
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))  


func _on_sound_slider_value_changed(value):
	var sound_effect_bus = AudioServer.get_bus_index("Sound")
	AudioServer.set_bus_volume_db(sound_effect_bus, linear_to_db(value))  

func _on_narrator_voice_slider_value_changed(value):
	var narrator_bus = AudioServer.get_bus_index("Narrator")
	AudioServer.set_bus_volume_db(narrator_bus, linear_to_db(value))  
