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


@onready var audio_player_walk = $SoundEffects/Walk
@onready var audio_player_parachute = $SoundEffects/Parachute
@onready var audio_player_general = $SoundEffects/General

var sound_spawned = preload("res://src/gameplay/audios/laugh.mp3")
var sound_attack = preload("res://src/gameplay/audios/sound frog/frogattack.mp3")
var sound_damage = preload("res://src/gameplay/audios/sound frog/frogdamage.mp3")

@onready var movement_particle = $Sprite2D/GPUParticles2D
@onready var blood_particle = $Sprite2D/GPUParticles2DBlood

func spawned():
	audio_player_general.stream = sound_spawned
	audio_player_general.pitch_scale = randf_range(0.9, 1.1)
	audio_player_general.play()
	update_attack_group()
	update_hp()


func _ready():
	navigation_agent.path_desired_distance = path_desired_distance
	navigation_agent.target_desired_distance = target_desired_distance
	
	randomize_toad()
	call_deferred("actor_setup")


func actor_setup():
	await get_tree().physics_frame
	
	# Now that the navigation map is no longer empty, set the movement target.
	agent_is_ready = true


func _on_health_dead():
	audio_player_general.stream = sound_damage
	audio_player_general.play()
	enemy_die.emit(money_per_kill)
	var color: Color = sprite.modulate
	color.a = 0.3
	sprite.modulate = color
	await get_tree().create_timer(1.0).timeout
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


func randomize_toad():
	var random_scale = randf_range(3.8, 4.4)
	sprite.scale = Vector2(random_scale, random_scale)
	sprite.modulate = Color(1, randf_range(0.8, 1.4), 1, 1)


func _on_health_health_update(old_value, new_value, damager_position):
	if old_value > new_value:
		knock_back(damager_position)
	
	audio_player_general.stream = sound_damage
	audio_player_general.play()
	blood_particle.rotation = get_angle_to(damager_position) + PI
	
