extends Node

class_name GarageGameplayManager

@onready var gameplay_manager: GameplayManager = $".."


func _on_train_cabin_player_entered_in_cabin():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.TRAIN)


func _on_fuel_tank_player_upgraded_fuel_tank():
	print("fuel upgrade")
	gameplay_manager.player_progress.train_fuel += 10
