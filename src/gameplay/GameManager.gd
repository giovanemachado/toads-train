extends Node

class_name GameplayManager

@export var player_progress: PlayerProgress

func change_scenes(next_scene: String):
	ResourceSaver.save(player_progress, player_progress.resource_path)
	SceneLoader.scene_transition(next_scene)
