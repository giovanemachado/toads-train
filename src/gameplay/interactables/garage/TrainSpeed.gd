extends Node2D

signal player_upgraded_train_speed

@export var cost_to_upgrade: int = 2
@export var amount: int = 1

func _on_interactable_player_interacted():
	player_upgraded_train_speed.emit(cost_to_upgrade, amount)
