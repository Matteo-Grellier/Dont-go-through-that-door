extends Node3D

signal audio_finished

@export var audio_sources: Array[AudioStream]
@export var audio_subtitles: Array[String]

@onready var audio_stream_player: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var subtitle: Label = $CanvasLayer/Subtitle

var current_played_audio = 0
var is_already_played: bool = false

var tween: Tween

func play_audio(source_index: int):
	if source_index >= audio_sources.size() or source_index < 0:
		return
	
	current_played_audio = source_index
	audio_stream_player.stream = audio_sources[source_index]
	audio_stream_player.play()
	
	display_subtitle(source_index)

func display_subtitle(subtitle_index: int):
	if tween != null:
		tween.kill()
	tween = get_tree().create_tween()
	
	subtitle.text = audio_subtitles[subtitle_index]
	
	tween.tween_property(subtitle, "modulate:a", 1, .5)
	
func hidden_subtitle():
	if tween != null:
		tween.kill()
	tween = get_tree().create_tween()
	
	tween.tween_property(subtitle, "modulate:a", 0, .5)

func _on_audio_stream_player_3d_finished():
	hidden_subtitle()
	audio_finished.emit()
