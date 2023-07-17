extends Node

class_name GarageGameplayManager

@onready var gameplay_manager: GameplayManager = $".."

@onready var fuel_label = $"../../UI/VBoxContainer/HBoxContainer3/Fuel"
@onready var money_label = $"../../UI/VBoxContainer/HBoxContainer2/Money"
@onready var distance_label = $"../../UI/VBoxContainer/HBoxContainer/Distance"
@onready var combo_label = $"../../UI/VBoxContainer/HBoxContainer4/ComboDebug"

func _ready():
	update_labels_debug()


func _on_train_cabin_player_entered_in_cabin():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.TRAIN)


func _on_fuel_tank_player_upgraded_fuel_tank(cost: int):
	if gameplay_manager.player_progress.money >= cost:
		gameplay_manager.player_progress.train_fuel += 10
		gameplay_manager.player_progress.money -= cost
		update_labels_debug()
		
		
func update_labels_debug():
	fuel_label.text = str(gameplay_manager.player_progress.train_fuel)
	money_label.text = str(gameplay_manager.player_progress.money)
	distance_label.text = str(gameplay_manager.player_progress.max_distance_reach)


func _on_player_update_combo(numb):
	combo_label.text = str(numb)
