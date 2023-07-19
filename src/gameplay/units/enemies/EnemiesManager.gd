extends Node

signal an_enemy_died

@onready var timer: Timer = $Timer

@export var timing_to_first_spawn: float = 1
@export var spawns_marks : Array[Marker2D]
@onready var train = $"../../Environment/Train"

var enemies: Dictionary = {}
var enemy_test = preload("res://src/gameplay/units/enemies/test/enemy_test_scene.tscn")
var wave_number = 3

func get_all_enemies():
	for child in get_children():
		if child.is_in_group(Globals.ENEMY_GROUP):
			enemies[child.name.to_lower()] = child
			
			if !child.enemy_die.is_connected(on_enemy_die):
				child.enemy_die.connect(on_enemy_die)


func _ready():
	timer.start(timing_to_first_spawn)


func spawn_enemies():
	var enemy_test_name = 'enemytest'
	
	var waves_of_enemies = [
		{ 
			wave = 0,
			wave_cooldown = 5,
			possible_spawning_positions = [
				{
					position_number = 0,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 3
						}
					]
				}
			]
		},
		{
			wave = 1,
			wave_cooldown = 10,
			possible_spawning_positions = [
				{
					position_number = 0,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 3
						}
					]
				},
				{
					position_number = 3,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 3
						}
					]
				}
			]
		},
		{
			wave = 2,
			wave_cooldown = 100,
			possible_spawning_positions = [
				{
					position_number = 0,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 1
						}
					]
				},
			]
		},
		{
			wave = 3,
			wave_cooldown = 5,
			possible_spawning_positions = [
				{
					position_number = 0,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 1
						}
					]
				},
			]
		},
		{
			wave = 4,
			wave_cooldown = 5,
			possible_spawning_positions = [
				{
					position_number = 1,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 1
						}
					]
				},
			]
		},
		{
			wave = 5,
			wave_cooldown = 5,
			possible_spawning_positions = [
				{
					position_number = 2,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 1
						}
					]
				},
			]
		},
		{
			wave = 6,
			wave_cooldown = 5,
			possible_spawning_positions = [
				{
					position_number = 3,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 1
						}
					]
				},
			]
		},
		{
			wave = 7,
			wave_cooldown = 5,
			possible_spawning_positions = [
				{
					position_number = 4,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 1
						}
					]
				},
			]
		},
		{
			wave = 8,
			wave_cooldown = 5,
			possible_spawning_positions = [
				{
					position_number = 5,
					enemies = [
						{
							type = enemy_test_name,
							qtd = 1
						}
					]
				},
			]
		}
	]
	
	var spawn_pos = waves_of_enemies[wave_number].possible_spawning_positions
	
	for k in spawn_pos.size():
		var current_spawn_pos = spawn_pos[k]
		
		for l in current_spawn_pos.enemies.size():
			var enemy_to_spawn = current_spawn_pos.enemies[l]
		
			if enemy_to_spawn.type.to_lower() == enemy_test_name:
				for m in enemy_to_spawn.qtd:
					var slightly_random_spawn_position = randomize_position(spawns_marks[current_spawn_pos.position_number].global_position)
					var enemy_to_spawn_instance = enemy_test.instantiate()
					enemy_to_spawn_instance.position = slightly_random_spawn_position
					add_child(enemy_to_spawn_instance)

	var multiplier = 0
	
	if train.current_distance > 100:
		multiplier = -1
	
	if train.current_distance > 200:
		multiplier = -2
		
	if train.current_distance > 300:
		multiplier = -3
		
	if train.current_distance > 400:
		multiplier = -4
		
	if train.current_distance > 500:
		multiplier = -5
		
	var cooldown = waves_of_enemies[wave_number].wave_cooldown - multiplier
	if cooldown < 0:
		cooldown = 0.1

		
	timer.start(cooldown)
	get_all_enemies()
	wave_number += 1

func randomize_position(pos: Vector2):
	var new_pos: Vector2 = pos
	new_pos.x += randf_range(-50, 50)
	new_pos.y += randf_range(-50, 50)
	return new_pos
	

func on_enemy_die(value: int):
	an_enemy_died.emit(value)


func _on_timer_timeout():
	spawn_enemies()
