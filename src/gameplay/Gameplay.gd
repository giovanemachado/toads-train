extends Node

class_name GameManager

@export var player_progress: Resource


func _on_train_stopped():
	change_scenes(Globals.MAIN_SCENES.GARAGE)
	

func change_scenes(next_scene: String):
	ResourceSaver.save(player_progress, player_progress.resource_path)
	get_tree().change_scene_to_file(next_scene)