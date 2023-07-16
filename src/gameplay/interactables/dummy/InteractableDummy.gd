extends Node2D

@onready var interactable: Interactable = $Interactable


func _on_interactable_player_interacted():
	print("player interacted with interectable dummy")
