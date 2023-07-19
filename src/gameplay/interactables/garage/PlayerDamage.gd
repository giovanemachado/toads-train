extends Node2D

signal player_upgraded_damage

@export var cost_to_upgrade: int = 2
@export var amount: int = 1

func _on_interactable_player_interacted():
	player_upgraded_damage.emit(cost_to_upgrade, amount)
