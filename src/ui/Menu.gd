extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file(Globals.MAIN_SCENES.GARAGE)


func _on_debug_go_to_garage_pressed():
	get_tree().change_scene_to_file(Globals.MAIN_SCENES.TRAIN)
