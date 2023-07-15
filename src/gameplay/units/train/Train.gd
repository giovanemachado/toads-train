extends Node2D

signal stopped

@onready var health: Health = $Health

@onready var fuel_bar: ProgressBar = $FuelBar
@onready var fuel_timer: Timer = $FuelTimer
@export var fuel_timing: float = 1
@export var initial_fuel: int = 50
@export var fuel_amount_per_tick = 2
var current_fuel: int


func _ready():
	current_fuel = initial_fuel
	fuel_timer.start(fuel_timing)
	fuel_bar.max_value = initial_fuel
	fuel_bar.value = initial_fuel


func spend_fuel():
	if (current_fuel - fuel_amount_per_tick < 0):
		current_fuel = 0
	else:
		current_fuel -= fuel_amount_per_tick
	
	fuel_bar.value = current_fuel
	
	if (current_fuel == 0):
		stopped.emit()


func _on_fuel_timer_timeout():
	spend_fuel()
	fuel_timer.start(fuel_timing)
