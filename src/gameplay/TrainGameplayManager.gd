extends Node

class_name TrainGameplayManager

signal money_updated

@onready var gameplay_manager: GameplayManager = $".."

func _on_train_stopped():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)


func _on_enemies_manager_an_enemy_died(value: int):
	gameplay_manager.player_progress.money += value
	money_updated.emit(gameplay_manager.player_progress.money)


func _on_player_player_is_dead():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)
