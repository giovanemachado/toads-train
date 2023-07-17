extends Node2D

class_name Attack

signal attacked

@onready var hit_box: Area2D = $Area2D
@onready var timer: Timer = $Timer

@export var attack_cooldown: float = 1
@export var attack_damage: int = 1
@export var attack_group: String

var attack_in_cooldown = false

func attack():
	if attack_in_cooldown:
		return

	var nodes: Array[Node2D] = hit_box.get_overlapping_bodies()
	
	for node in nodes:
		if node.is_in_group(attack_group):
			node.health.damage(attack_damage, global_position)
			attacked.emit()

	attack_in_cooldown = true
	timer.start(attack_cooldown)


func _on_timer_timeout():
	attack_in_cooldown = false
