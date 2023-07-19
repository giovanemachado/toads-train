extends Node

class_name GarageGameplayManager

@onready var gameplay_manager: GameplayManager = $".."

@onready var fuel_label = $"../../UI/VBoxContainer/HBoxContainer3/Fuel"
@onready var resist_label = $"../../UI/VBoxContainer/HBoxContainer6/ResistDebug"
@onready var speed_label = $"../../UI/VBoxContainer/HBoxContainer5/SpeedDebug"
@onready var money_label = $"../../UI/VBoxContainer/HBoxContainer2/Money"
@onready var distance_label = $"../../UI/VBoxContainer/HBoxContainer/Distance"
@onready var combo_label = $"../../UI/VBoxContainer/HBoxContainer4/ComboDebug"

@onready var player_speed_label =$"../../UI/VBoxContainer/HBoxContainer4/Money"
@onready var player_damage_label = $"../../UI/VBoxContainer/HBoxContainer8/ResistDebug"
@onready var player_hp_label = $"../../UI/VBoxContainer/HBoxContainer7/SpeedDebug"

func _ready():
	update_labels_debug()


func _on_train_cabin_player_entered_in_cabin():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.TRAIN)


func _on_fuel_tank_player_upgraded_fuel_tank(cost: int, amount):
	if gameplay_manager.player_progress.money >= cost:
		gameplay_manager.player_progress.train_fuel += amount
		gameplay_manager.player_progress.money -= cost
		update_labels_debug()
		
		
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
	combo_label.text = str(numb)


func _on_train_speed_player_upgraded_train_speed(cost, amount):
	if gameplay_manager.player_progress.money >= cost:
		gameplay_manager.player_progress.train_speed += amount
		gameplay_manager.player_progress.money -= cost
		update_labels_debug()


func _on_train_resistence_player_upgraded_train_resist(cost, amount):
	if gameplay_manager.player_progress.money >= cost:
		gameplay_manager.player_progress.train_resist += amount
		gameplay_manager.player_progress.money -= cost
		update_labels_debug()


func _on_player_speed_player_upgraded_speed(cost, amount):
	if gameplay_manager.player_progress.money >= cost:
		gameplay_manager.player_progress.speed += amount
		gameplay_manager.player_progress.money -= cost
		update_labels_debug()


func _on_player_hp_player_upgraded_hp(cost, amount):
	if gameplay_manager.player_progress.money >= cost:
		gameplay_manager.player_progress.hp += amount
		gameplay_manager.player_progress.money -= cost
		update_labels_debug()


func _on_player_damage_player_upgraded_damage(cost, amount):
	if gameplay_manager.player_progress.money >= cost:
		gameplay_manager.player_progress.damage += amount
		gameplay_manager.player_progress.money -= cost
		update_labels_debug()
