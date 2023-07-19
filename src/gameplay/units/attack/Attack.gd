extends Node2D

class_name Attack

signal successful_attack
signal attack_try
signal attack_is_done

@onready var hit_box: Area2D = $Area2D
@onready var timer: Timer = $Timer
@onready var delay_to_attack_timer: Timer = $DelayToAttack

@export var attack_cooldown: float = 1
@export var attack_delay: float = 0.5
@export var attack_damage: int = 1
@export var attack_group: String

@export var strong_attack_cooldown: float = 1
@export var strong_attack_delay: float = 0.5
@export var strong_attack_damage: int = 1

var damage_to_cause = 0
var attack_in_cooldown = false

func attack():
	if attack_in_cooldown:
		return

	delay_to_attack_timer.start(attack_delay)
	damage_to_cause = attack_damage
	attack_try.emit()
	attack_in_cooldown = true
	timer.start(attack_cooldown + attack_delay)


func _on_timer_timeout():
	attack_in_cooldown = false
	attack_is_done.emit()


func strong_attack():
	if attack_in_cooldown:
		return

	delay_to_attack_timer.start(strong_attack_delay)
	damage_to_cause = strong_attack_damage
	
	attack_try.emit()
	attack_in_cooldown = true
	timer.start(strong_attack_cooldown + strong_attack_delay)


func cause_damage():
	var nodes: Array[Node2D] = hit_box.get_overlapping_bodies()
	
	for node in nodes:
		if node.is_in_group(attack_group):
			node.health.damage(damage_to_cause, global_position)
			successful_attack.emit()

func _on_delay_to_attack_timeout():
	cause_damage()
