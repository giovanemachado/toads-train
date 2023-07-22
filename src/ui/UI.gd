extends Control


@onready var distance_label: Label = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Distance
@onready var money_label: Label = $MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer2/Money

func _on_train_distance_updated(value: int):
	distance_label.text = str(value)
	

func _on_train_gameplay_manager_money_updated(value: int):
	money_label.text = str(value)
