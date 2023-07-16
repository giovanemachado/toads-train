extends CharacterBody2D

signal enemy_die

@onready var health: Health = $Health


func _on_health_dead():
	enemy_die.emit()
