extends Node2D

class_name Interactable

signal player_interacted

@onready var icon = $"../MarginContainer"
var there_is_interactable_in_range: bool = false


func in_player_range():
	there_is_interactable_in_range = true
	icon.show()


func out_of_player_range():
	there_is_interactable_in_range = false
	if get_parent().name != "TrainCabin":
		icon.hide()


func player_interact():
	if !there_is_interactable_in_range:
		return
	
	player_interacted.emit()
