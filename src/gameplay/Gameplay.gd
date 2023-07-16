extends Node


func _on_train_stopped():
	get_tree().change_scene_to_file("res://src/main_scenes/garage_scene.tscn")
