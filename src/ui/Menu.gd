extends Control

func _on_play_pressed():
	SceneLoader.scene_transition(Globals.MAIN_SCENES.GARAGE)


func _on_debug_go_to_garage_pressed():
	SceneLoader.scene_transition(Globals.MAIN_SCENES.TRAIN)
