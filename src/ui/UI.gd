extends Control


func _on_menu_pressed():
	get_tree().change_scene_to_file(Globals.MAIN_SCENES.MENU)


func _on_debug__garage_pressed():
	get_tree().change_scene_to_file(Globals.MAIN_SCENES.GARAGE)
