extends Node

class_name TrainGameplayManager

signal money_updated

@onready var gameplay_manager: GameplayManager = $".."
@onready var train: Train = $"../../Environment/Train"

@export var fuel_extra_on_leaking: int = 2
@export var speed_extra_on_explosive_valve: int = 50
@onready var event_label = $"../../UI/Control/MarginContainer/VBoxContainer/HBoxContainer3/Event"

@onready var player: Player = %Player

var normal_fuel_leaking: int = 0

func _on_train_stopped():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)


func _on_enemies_manager_an_enemy_died(value: int):
	gameplay_manager.player_progress.money += value
	money_updated.emit(gameplay_manager.player_progress.money)


func _on_player_player_is_dead():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)


func _on_fuel_leaking_event_started(event_name):
	# if restarted, it will increase. Ok
	normal_fuel_leaking = train.fuel_amount_per_tick
	train.fuel_amount_per_tick += fuel_extra_on_leaking
	event_label.text = event_name
	player.text_box.show_text("We have a fuel leaking!")


func _on_fuel_leaking_event_success(event_name):
	train.fuel_amount_per_tick = normal_fuel_leaking
	event_label.text = ""

func _on_explosive_valve_2_event_fail(event_name):
	train.current_speed += speed_extra_on_explosive_valve
	event_label.text = ""


func _on_explosive_valve_3_event_success(event_name):
	train.current_speed += speed_extra_on_explosive_valve
	event_label.text = ""


# motor health
func _on_health_dead():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)


func get_difficult_multiplier():
	var difficult_multiplier = 0
	
	if train.current_distance > 200:
		difficult_multiplier = 1
	
	if train.current_distance > 800:
		difficult_multiplier = 2
		
	if train.current_distance > 1000:
		difficult_multiplier = 3
		
	if train.current_distance > 1500:
		difficult_multiplier = 4
		
	if train.current_distance > 2500:
		difficult_multiplier = 5
	
	return difficult_multiplier


func _on_fuel_leaking_event_fail(event_name):
	event_label.text = ""


func _on_explosive_valve_event_started(event_name):
	event_label.text = event_name
	player.text_box.show_text("A valve is about to explode!")


func _on_explosive_valve_event_success(event_name):
	event_label.text = ""

func _on_explosive_valve_event_fail(event_name):
	train.current_speed += speed_extra_on_explosive_valve
	event_label.text = ""
	

func _on_explosive_valve_2_event_started(event_name):
	event_label.text = event_name
	player.text_box.show_text("A valve is about to explode!")


func _on_explosive_valve_2_event_success(event_name):
	event_label.text = ""


func _on_explosive_valve_3_event_started(event_name):
	event_label.text = event_name
	player.text_box.show_text("A valve is about to explode!")

func _on_explosive_valve_3_event_fail(event_name):
	event_label.text = ""
