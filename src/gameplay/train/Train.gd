extends Node2D

class_name Train

signal stopped
signal distance_updated

@onready var gameplay_manager: GameplayManager = $"../../GameplayManager"

@export var train_max_speed: int = 700

@export_group("Fuel")
@onready var fuel_bar: ProgressBar = $"../../UI/Control/MarginContainer/HBoxContainer/MarginContainer2/VBoxContainer2/FuelBar"
@onready var fuel_timer: Timer = $FuelTimer
@export var fuel_timing: float = 1
@export var fuel_amount_per_tick = 2

@export_group("Distance")
@onready var distance_timer: Timer = $Distance/DistanceTimer
@export var distance_timing: float = 1
@export var distance_amount_per_tick = 1

@onready var motor = $"../Motor"

var current_distance: int = 0

var current_fuel: int = 0
var current_speed: int = 0
var current_resist: int = 0

func _ready():
	current_fuel = gameplay_manager.player_progress.train_fuel
	current_speed = gameplay_manager.player_progress.train_speed
	current_resist = gameplay_manager.player_progress.train_resist
	
	fuel_timer.start(fuel_timing)
	if fuel_bar != null:
		fuel_bar.max_value = current_fuel
		fuel_bar.value = current_fuel
	
	distance_timer.start(distance_timing)
	distance_updated.emit(current_distance)


func _process(delta):
#	if current_speed >= train_max_speed:
#		stopped.emit()
	pass


func spend_fuel():
	if (current_fuel - fuel_amount_per_tick < 0):
		current_fuel = 0
	else:
		current_fuel -= fuel_amount_per_tick
	
	fuel_bar.value = current_fuel
	
	if (current_fuel == 0):
		stopped.emit()


func increase_distance():
	current_distance += distance_amount_per_tick
	
	if gameplay_manager.player_progress.max_distance_reach < current_distance:
		gameplay_manager.player_progress.max_distance_reach = current_distance
	
	distance_updated.emit(current_distance)


func _on_fuel_timer_timeout():
	spend_fuel()
	fuel_timer.start(fuel_timing)


func _on_distance_timer_timeout():
	increase_distance()
	var speed_in_miliseconds: float = float(current_speed) / 1000.0
	var next_timing: float = distance_timing - speed_in_miliseconds

	if next_timing < 0.1:
		next_timing = 0.1
	
	distance_timer.start(next_timing)
