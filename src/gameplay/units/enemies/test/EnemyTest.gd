extends CharacterBody2D

class_name EnemyTest

signal enemy_die

@onready var movement: Movement = $Movement
@onready var health: Health = $Health
@onready var attack: Attack = $Attack

@export var target: CharacterBody2D
@export var path_desired_distance = 4.0
@export var target_desired_distance = 4.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

@export var money_per_kill: int = 1

@onready var sprite = $AnimatedSprite2D


var agent_is_ready: bool = false

func _ready():
	navigation_agent.path_desired_distance = path_desired_distance
	navigation_agent.target_desired_distance = target_desired_distance
	
	call_deferred("actor_setup")


func actor_setup():
	await get_tree().physics_frame
	
	# Now that the navigation map is no longer empty, set the movement target.
	agent_is_ready = true


func _on_health_dead():
	enemy_die.emit(money_per_kill)
	queue_free()


func _on_movement_turning_to(direction: int):
	sprite.flip_h = direction == 1
