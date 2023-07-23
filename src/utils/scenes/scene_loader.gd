extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var music_lobby = preload("res://src/gameplay/audios/music game/music lobby.mp3")
var music_play = preload("res://src/gameplay/audios/music game/musicplay.mp3")
var tween: Tween

func _ready():
	start_lobby_song()
	
	
func scene_transition(target: String):
	animation_player.play("dissolve")
	await animation_player.animation_finished
	
	if target == "res://src/main_scenes/train_scene.tscn":
		start_play_song()
	else:
		start_lobby_song()
	
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("dissolve")


func start_lobby_song():
	start_song(music_lobby)


func start_play_song():
	start_song(music_play)


func start_song(music):
	if audio_stream_player.stream == music:
		return
		
	if tween:
		tween.kill()
		
	tween = create_tween()
	
	if audio_stream_player.playing:
		tween.tween_property(audio_stream_player, "volume_db", -80, 0.5)
	
	audio_stream_player.stream = music
	audio_stream_player.play()
	tween.tween_property(audio_stream_player, "volume_db", -8, 0.5)
	
