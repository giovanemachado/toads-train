extends Node2D

class_name Interactable

signal player_interacted

@onready var icon: Sprite2D = $Icon
var there_is_interactable_in_rage: bool = false


func in_player_range():
	there_is_interactable_in_rage = true
	icon.show()


func out_of_player_range():
	there_is_interactable_in_rage = false
	icon.hide()


func player_interact():
	if !there_is_interactable_in_rage:
		return
	
	player_interacted.emit()
