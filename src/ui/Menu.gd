extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://src/main_scenes/train_scene.tscn")


func _on_debug_go_to_garage_pressed():
	get_tree().change_scene_to_file("res://src/main_scenes/garage_scene.tscn")
