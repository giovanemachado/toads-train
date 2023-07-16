extends Node

signal an_enemy_died

var enemies: Dictionary = {}

func _ready():
	get_all_enemies()

func get_all_enemies():
	for child in get_children():
		if child.is_in_group(Globals.ENEMY_GROUP):
			enemies[child.name.to_lower()] = child
			
			if !child.enemy_die.is_connected(on_enemy_die):
				child.enemy_die.connect(on_enemy_die)

func on_enemy_die(value: int):
	an_enemy_died.emit(value)
