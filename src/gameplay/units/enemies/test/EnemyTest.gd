extends Enemy

class_name EnemyTest

@onready var movement: Movement = $Movement
@onready var attack: Attack = $Attack

@export var target: CharacterBody2D
@export var path_desired_distance = 4.0
@export var target_desired_distance = 4.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

@export var money_per_kill: int = 1

@onready var sprite = $Sprite2D

var agent_is_ready: bool = false

var attack_group_should_be_updated_to_motor = true

var hp_should_be_updated = true
var extra_hp_by_difficult = 0

func _ready():
	navigation_agent.path_desired_distance = path_desired_distance
	navigation_agent.target_desired_distance = target_desired_distance
	
	call_deferred("actor_setup")

func _process(delta):
	update_attack_group()
	update_hp()
	

func actor_setup():
	await get_tree().physics_frame
	
	# Now that the navigation map is no longer empty, set the movement target.
	agent_is_ready = true


func _on_health_dead():
	enemy_die.emit(money_per_kill)
	queue_free()


func update_attack_group():
	if attack_group_should_be_updated_to_motor:
		return
	
	attack.attack_group = 'motor'
	attack_group_should_be_updated_to_motor = true
	
func update_hp():
	if hp_should_be_updated:
		return
	
	health.max_health_points = 1 + extra_hp_by_difficult
	health.update_max_hp()
	hp_should_be_updated = true
	
func _on_movement_turning_to(direction: int):
	sprite.flip_h = direction != 1
	
func attack_motor():
	attack_group_should_be_updated_to_motor = false

func difficult_was_born(difficult: int):
	hp_should_be_updated = false
	extra_hp_by_difficult = difficult
