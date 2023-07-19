extends Node

class_name GarageGameplayManager

@onready var gameplay_manager: GameplayManager = $".."

@onready var fuel_label = $"../../UI/VBoxContainer/HBoxContainer3/Fuel"
@onready var resist_label = $"../../UI/VBoxContainer/HBoxContainer6/ResistDebug"
@onready var speed_label = $"../../UI/VBoxContainer/HBoxContainer5/SpeedDebug"
@onready var money_label = $"../../UI/VBoxContainer/HBoxContainer2/Money"
@onready var distance_label = $"../../UI/VBoxContainer/HBoxContainer/Distance"
#@onready var combo_label = $"../../UI/VBoxContainer/HBoxContainer4/ComboDebug"

@onready var player_speed_label =$"../../UI/VBoxContainer/HBoxContainer4/Money"
@onready var player_damage_label = $"../../UI/VBoxContainer/HBoxContainer8/ResistDebug"
@onready var player_hp_label = $"../../UI/VBoxContainer/HBoxContainer7/SpeedDebug"

func _ready():
	update_labels_debug()


func _on_train_cabin_player_entered_in_cabin():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.TRAIN)


func update_labels_debug():
	fuel_label.text = str(gameplay_manager.player_progress.train_fuel)
	resist_label.text = str(gameplay_manager.player_progress.train_resist)
	speed_label.text = str(gameplay_manager.player_progress.train_speed)
	money_label.text = str(gameplay_manager.player_progress.money)
	distance_label.text = str(gameplay_manager.player_progress.max_distance_reach)
	player_speed_label.text = str(gameplay_manager.player_progress.speed)
	player_damage_label.text = str(gameplay_manager.player_progress.damage)
	player_hp_label.text = str(gameplay_manager.player_progress.hp)


func _on_player_update_combo(numb):
#	combo_label.text = str(numb)
	pass


func _on_fuel_tank_upgrade_success(upgrade_name):
	update_labels_debug()


func _on_train_speed_upgrade_success(upgrade_name):
	update_labels_debug()
	
	

func _on_player_damage_upgrade_success(upgrade_name):
	update_labels_debug()
	
	
func _on_player_hp_upgrade_success(upgrade_name):
	update_labels_debug()
	

func _on_player_speed_upgrade_success(upgrade_name):
	update_labels_debug()
	

func _on_train_resistence_upgrade_success(upgrade_name):
	update_labels_debug()
