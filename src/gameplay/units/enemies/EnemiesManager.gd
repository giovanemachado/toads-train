extends Node

signal an_enemy_died

@onready var timer: Timer = $Timer

@export var timing_to_first_spawn: float = 1
@export var spawns_marks : Array[Marker2D]
@onready var train = $"../../Environment/Train"

var enemies: Dictionary = {}
var enemy_test = preload("res://src/gameplay/units/enemies/test/enemy_test_scene.tscn")
var wave_number = 0
@export var chance_of_attack_motor = 30
@export var max_number_of_enemies: int = 50

var total_enemies = 0

@onready var train_gameplay_manager: TrainGameplayManager = $"../../GameplayManager/TrainGameplayManager"

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
	var waves_of_enemies = get_waves_of_enemies()
	var difficult_multiplier = train_gameplay_manager.get_difficult_multiplier()
	var spawn_pos = waves_of_enemies[wave_number].possible_spawning_positions
	
	for k in spawn_pos.size():
		var current_spawn_pos = spawn_pos[k]
		
		if total_enemies <= max_number_of_enemies:
			for l in current_spawn_pos.enemies.size():
				var enemy_to_spawn = current_spawn_pos.enemies[l]
			
				if enemy_to_spawn.type.to_lower() == enemy_test_name:
					var qtd_to_spawn = randi_range(2, enemy_to_spawn.qtd + difficult_multiplier)
					
					for m in qtd_to_spawn:
						var slightly_random_spawn_position = randomize_position(spawns_marks[current_spawn_pos.position_number].global_position)
						var enemy_to_spawn_instance = enemy_test.instantiate()
						enemy_to_spawn_instance.position = slightly_random_spawn_position
						
						var n = randf_range(0, 100)
						
						if chance_of_attack_motor > n:
							enemy_to_spawn_instance.attack_motor()
							enemy_to_spawn_instance.difficult_was_born(difficult_multiplier)
						
						add_child(enemy_to_spawn_instance)
						enemy_to_spawn_instance.spawned()
						total_enemies += 1


	var cooldown = timing_to_first_spawn - difficult_multiplier
	if cooldown < 0:
		cooldown = 0.1

	timer.start(cooldown)
	get_all_enemies()
	wave_number += 1
	
	if wave_number > 5:
		wave_number = 0


func randomize_position(pos: Vector2):
	var new_pos: Vector2 = pos
	new_pos.x += randf_range(-100, 100)
	new_pos.y += randf_range(-100, 100)
	return new_pos
	

func on_enemy_die(value: int):
	an_enemy_died.emit(value)
	total_enemies -= 1


func _on_timer_timeout():
	spawn_enemies()

func get_waves_of_enemies():
	var enemy_test_name = 'enemytest'
	var w = [
		{
			wave_cooldown = 10,
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
			wave_cooldown = 10,
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
			wave_cooldown = 10,
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
			wave_cooldown = 10,
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
			wave_cooldown = 10,
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
			wave_cooldown = 10,
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
	
	return w
