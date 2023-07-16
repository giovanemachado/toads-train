extends Control


@onready var distance_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/Distance
@onready var money_label: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Money


func _on_menu_pressed():
	get_tree().change_scene_to_file(Globals.MAIN_SCENES.MENU)


func _on_debug__garage_pressed():
	get_tree().change_scene_to_file(Globals.MAIN_SCENES.GARAGE)


func _on_train_distance_updated(value: int):
	distance_label.text = str(value)
	

func _on_train_gameplay_manager_money_updated(value: int):
	money_label.text = str(value)
