extends CharacterBody2D

class_name Player

signal player_is_dead

signal update_combo(numb: int)

@onready var gameplay_manager: GameplayManager = $"../GameplayManager"

@onready var attack: Attack = $Attack
@onready var movement: Movement = $Movement
@onready var health: Health = $Health
@onready var interaction: Interaction = $Interaction
@onready var life_bar: ProgressBar = %LifeBar
@onready var sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = $Camera2D
@onready var player_state_manager: PlayerStateManager = $PlayerStateManager
@onready var text_box: TextBox = $TextBox

var life_bar_is_ready = false
var tween: Tween

@onready var audio_player_walk = $SoundEffects/Walk
@onready var audio_player_general_sounds = $SoundEffects/GeneralSounds
var sound_attack = preload("res://src/gameplay/audios/sound player/attack.mp3")
var sound_interact = preload("res://src/gameplay/audios/sound player/interaction.mp3")
var sound_death = preload("res://src/gameplay/audios/sound player/playerdeath.mp3")
var sound_groan1 = preload("res://src/gameplay/audios/sound player/groan1.mp3")
var sound_groan2 = preload("res://src/gameplay/audios/sound player/groan2.mp3")
var sound_groan3 = preload("res://src/gameplay/audios/sound player/groan3.mp3")
var sound_alert = preload("res://src/gameplay/audios/sound player/playeralert.mp3")

@onready var movement_particle: GPUParticles2D = $Sprite2D/GPUParticles2D

func _ready():
	health.max_health_points = gameplay_manager.player_progress.hp
	movement.speed = gameplay_manager.player_progress.speed
	attack.attack_damage = gameplay_manager.player_progress.damage
	
	# isso pode ser null quando estamos na garage_scene
	if !life_bar_is_ready && life_bar != null:
		life_bar.max_value = health.max_health_points
		life_bar.value = health.max_health_points
		life_bar_is_ready = true
	
	
func _physics_process(delta):
	if player_state_manager.current_state.name.to_lower() != "playerstaggerstate" && player_state_manager.current_state.name.to_lower() != "playerattackstate":
		var input_vector = Input.get_vector("player_left", "player_right", "player_up", "player_down")
		movement.movement(input_vector)
		
		if input_vector != Vector2.ZERO && !audio_player_walk.playing:
			audio_player_walk.play()
		elif input_vector == Vector2.ZERO:
			audio_player_walk.stop()
			
		if input_vector != Vector2.ZERO && !movement_particle.emitting:
			movement_particle.emitting = true
		elif input_vector == Vector2.ZERO:
			movement_particle.emitting = false
	
	
	if Input.is_action_just_pressed("player_attack"):
		attack.attack()
	
	
	if Input.is_action_just_pressed("player_interact"):
		interaction.interaction()


func _on_health_health_update(old_value, new_value, damager_position: Vector2):
	if !life_bar_is_ready && life_bar != null:
		life_bar.max_value = health.max_health_points
		life_bar.value = health.max_health_points
		life_bar_is_ready = true
	
	if life_bar != null:
		life_bar.value = new_value
		if tween:
			tween.kill()

		audio_player_general_sounds.stream = [sound_groan1, sound_groan2, sound_groan3].pick_random()
		audio_player_general_sounds.play()
		
		tween = create_tween()
		tween.tween_property(life_bar, "modulate", Color(1, 1, 1, 0), 0.2)
		tween.tween_property(life_bar, "modulate", Color(1, 1, 1, 1), 0.3)
		


func _on_health_dead():
	player_is_dead.emit()


func _on_movement_turning_to(direction: int):
	sprite.flip_h = direction != 1


func _on_attack_attacked():
	camera.shake(0.20, 2.5)


func _on_player_attack_update_combo(numb):
	update_combo.emit(numb)


func _on_interaction_interacted():
	audio_player_general_sounds.stream = sound_interact
	audio_player_general_sounds.play()


func _on_attack_attack_try():
	audio_player_general_sounds.stream = sound_attack
	audio_player_general_sounds.play()


func _on_fuel_leaking_event_started(event_name):
	audio_player_general_sounds.stream = sound_alert
	audio_player_general_sounds.play()


func _on_explosive_valve_event_started(event_name):
	audio_player_general_sounds.stream = sound_alert
	audio_player_general_sounds.play()


func _on_explosive_valve_2_event_started(event_name):
	audio_player_general_sounds.stream = sound_alert
	audio_player_general_sounds.play()


func _on_explosive_valve_3_event_started(event_name):
	audio_player_general_sounds.stream = sound_alert
	audio_player_general_sounds.play()
