extends Node2D

class_name Health

signal health_update(old_value: int, new_value: int, damager_position: Vector2)
signal dead
signal stagger
signal stagger_recovered

@onready var timer: Timer = $Timer
@export var stagger_timing: float = 1
var is_damaged: bool = false
@export var max_health_points = 10

var health_points: int

func _ready():
	health_points = max_health_points


func heal(amount: int):
	var old_value = health_points
	if (health_points + amount > max_health_points):
		health_points = max_health_points
	else:
		health_points += amount

	health_update.emit(old_value, health_points, Vector2.ZERO)


func damage(amount: int, damager_position: Vector2):
	is_damaged = true
	stagger.emit()
	timer.start(stagger_timing)
	
	var old_value = health_points
	
	if (health_points - amount < 0):
		health_points = 0
	else:
		health_points -= amount

	health_update.emit(old_value, health_points, damager_position)
	
	if (health_points == 0):
		death()


func death():
	dead.emit()


func _on_timer_timeout():
	is_damaged = false
	stagger_recovered.emit()
