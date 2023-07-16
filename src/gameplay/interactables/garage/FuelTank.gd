extends Node2D

signal player_upgraded_fuel_tank

func _on_interactable_player_interacted():
	player_upgraded_fuel_tank.emit()
