extends Node

class_name TrainGameplayManager

@onready var gameplay_manager: GameplayManager = $".."

func _on_train_stopped():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)
