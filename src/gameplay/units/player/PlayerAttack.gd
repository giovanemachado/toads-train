extends Node


signal update_combo(numb: int)


@onready var attack_area: Area2D = $"../Attack/Area2D"
@onready var right_attack_position: Marker2D = $RightAttackPosition
@onready var left_attack_position: Marker2D = $LeftAttackPosition

@onready var combo_timer: Timer = $ComboTimer
@export var max_combo: int = 3
@export var reset_combo_timing: float = 1

var sequence: int = 0

func combo():
	if sequence < max_combo:
		sequence += 1
	
	update_combo.emit(sequence)
	combo_timer.start(reset_combo_timing)


func _on_movement_turning_to(direction: int):
	if direction == 1: # right
		attack_area.position = right_attack_position.position
		
	if direction == 0: # left
		attack_area.position = left_attack_position.position


func _on_attack_attacked():
	combo()


func _on_combo_timer_timeout():
	sequence = 0
	update_combo.emit(sequence)
