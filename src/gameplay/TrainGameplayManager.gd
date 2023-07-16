extends Node

class_name TrainGameplayManager

@onready var gameplay_manager: GameplayManager = $".."

func _on_train_stopped():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)


func _on_enemies_manager_an_enemy_died(value: int):
	gameplay_manager.player_progress.money += value
