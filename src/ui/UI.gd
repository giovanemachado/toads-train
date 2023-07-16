extends Control


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://src/main_scenes/menu_scene.tscn")


func _on_debug__garage_pressed():
	get_tree().change_scene_to_file("res://src/main_scenes/garage_scene.tscn")
