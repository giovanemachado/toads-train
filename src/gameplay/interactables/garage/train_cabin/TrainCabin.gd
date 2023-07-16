extends Node2D


func _on_interactable_player_interacted():
	get_tree().change_scene_to_file("res://src/main_scenes/train_scene.tscn")
