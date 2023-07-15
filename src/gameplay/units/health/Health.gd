extends Node2D

class_name Health

signal health_update(old_value: int, new_value: int)
signal dead

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

	health_update.emit(old_value, health_points)


func damage(amount: int):
	var old_value = health_points
	if (health_points - amount < 0):
		health_points = 0
	else:
		health_points -= amount

	health_update.emit(old_value, health_points)
	
	if (health_points == 0):
		death()


func death():
	dead.emit()
