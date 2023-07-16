extends Node

@onready var attack_area: Area2D = $"../Attack/Area2D"
@onready var right_attack_position: Marker2D = $RightAttackPosition
@onready var left_attack_position: Marker2D = $LeftAttackPosition

func _on_movement_turning_to(direction: int):
	if direction == 1: # right
		attack_area.position = right_attack_position.position
		
	if direction == 0: # left
		attack_area.position = left_attack_position.position
