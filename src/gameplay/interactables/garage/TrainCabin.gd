extends Node2D

signal player_entered_in_cabin

func _on_interactable_player_interacted():
	player_entered_in_cabin.emit()
