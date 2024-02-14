extends VBoxContainer

signal go_back

@onready var sensitivity_slider: HSlider = $Sliders/SensitivitySlider
@onready var sound_slider: HSlider = $Sliders/SoundSlider

func _ready():
	# Get value from GameManager and set default values for sliders
	pass

func _on_go_back_button_pressed():
	go_back.emit()

func _on_sound_slider_drag_ended(value_changed):
	# Change the value of the sound
	pass

func _on_sensitivity_slider_drag_ended(value_changed):
	# Change the value of the mouse sensitivity
	pass
