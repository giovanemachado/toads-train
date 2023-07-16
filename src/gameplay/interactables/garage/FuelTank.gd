extends Node2D

signal player_upgraded_fuel_tank

@export var cost_to_upgrade: int = 2

func _on_interactable_player_interacted():
	player_upgraded_fuel_tank.emit(cost_to_upgrade)
