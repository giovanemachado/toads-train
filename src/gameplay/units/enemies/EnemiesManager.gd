extends Node

signal an_enemy_died

@onready var spawn: Marker2D = $Marker2D
@onready var timer: Timer = $Timer

@export var timing_to_spawn: float = 1

var enemies: Dictionary = {}
var enemy_test = preload("res://src/gameplay/units/enemies/test/enemy_test_scene.tscn")

func get_all_enemies():
	for child in get_children():
		if child.is_in_group(Globals.ENEMY_GROUP):
			enemies[child.name.to_lower()] = child
			
			if !child.enemy_die.is_connected(on_enemy_die):
				child.enemy_die.connect(on_enemy_die)

func _ready():
	timer.start(timing_to_spawn)

func spawn_enemies():
	var enemy_test_instance = enemy_test.instantiate()
	enemy_test_instance.position = spawn.position
	add_child(enemy_test_instance)
	get_all_enemies()


func on_enemy_die(value: int):
	an_enemy_died.emit(value)


func _on_timer_timeout():
	spawn_enemies()
	timer.start(timing_to_spawn)
