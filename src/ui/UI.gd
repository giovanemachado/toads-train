extends Control

@onready var distance_label: Label = $MarginContainer/VBoxContainer/Distance


func _on_menu_pressed():
	get_tree().change_scene_to_file(Globals.MAIN_SCENES.MENU)


func _on_debug__garage_pressed():
	get_tree().change_scene_to_file(Globals.MAIN_SCENES.GARAGE)


func _on_train_distance_updated(value: int):
	distance_label.text = str(value)
