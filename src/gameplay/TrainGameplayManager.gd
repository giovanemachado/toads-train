extends Node

class_name TrainGameplayManager

signal money_updated

@onready var gameplay_manager: GameplayManager = $".."
@onready var train: Train = $"../../Environment/Train"

@export var fuel_extra_on_leaking: int = 2
@export var speed_extra_on_explosive_valve: int = 50

@onready var player: Player = %Player

var normal_fuel_leaking: int = 0

@onready var sound_effects = $"../../SoundEffects"
@onready var sound_effects_event = $"../../SoundEffectsEvent"
var sound_horn = preload("res://src/gameplay/audios/horn.mp3")
var sound_alert = preload("res://src/gameplay/audios/sound train/hornalert.mp3")
var sound_fuel = preload("res://src/gameplay/audios/sound train/hornfuel.mp3")
var sound_breaking = preload("res://src/gameplay/audios/sound train/trainbreaking.mp3")
var sound_damage = preload("res://src/gameplay/audios/sound train/traindamage.mp3")
var sound_gate = preload("res://src/gameplay/audios/gate.mp3")
var sound_explosion = preload("res://src/gameplay/audios/explosin.mp3")
var sound_fuel_leaking = preload("res://src/gameplay/audios/liquid_leaking.mp3")

@onready var motor = $"../../Environment/Motor"
var current_distance_mark = 0

@onready var alert_rect = $"../../UI/Control/AlertRect"
@onready var alert_container = $"../../UI/Control/AlertContainer"
@onready var fuel_leaking_alert =$"../../UI/Control/AlertContainer/HBoxContainer/MarginContainer/VBoxContainer/FuelLeakingAlert"
@onready var valve_alert =$"../../UI/Control/AlertContainer/HBoxContainer/MarginContainer/VBoxContainer/ValveAlert"

func _ready():
	sound_effects.stream = sound_horn
	sound_effects.play()
	money_updated.emit(gameplay_manager.player_progress.money)


func _on_train_stopped():
	sound_effects.stream = sound_breaking
	sound_effects.play()
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)


func _on_enemies_manager_an_enemy_died(value: int):
	gameplay_manager.player_progress.money += value
	money_updated.emit(gameplay_manager.player_progress.money)


func _on_player_player_is_dead():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)


func _on_fuel_leaking_event_started(event_name):
	# if restarted, it will increase. Ok
	normal_fuel_leaking = train.fuel_amount_per_tick
	train.fuel_amount_per_tick += fuel_extra_on_leaking
	fuel_alert_started()
	sound_effects.stream = sound_alert
	sound_effects.play()
	sound_effects.stream = sound_alert
	sound_effects.play()


func _on_fuel_leaking_event_success(event_name):
	train.fuel_amount_per_tick = normal_fuel_leaking
	alert_finished()


func _on_explosive_valve_2_event_started(event_name):
	valve_alert_started()
	sound_effects.stream = sound_alert
	sound_effects.play()


func _on_explosive_valve_2_event_fail(event_name):
	sound_effects_event.stream = sound_explosion
	sound_effects_event.play()
	train.current_speed += speed_extra_on_explosive_valve
	motor.health.damage(10, Vector2.ZERO)
	alert_finished()


func _on_explosive_valve_3_event_fail(event_name):
	sound_effects_event.stream = sound_explosion
	sound_effects_event.play()
	train.current_speed += speed_extra_on_explosive_valve
	motor.health.damage(10, Vector2.ZERO)
	alert_finished()
	
	
func _on_explosive_valve_3_event_started(event_name):
	valve_alert_started()
	sound_effects.stream = sound_alert
	sound_effects.play()


func _on_explosive_valve_event_started(event_name):
	valve_alert_started()


func _on_explosive_valve_event_fail(event_name):
	sound_effects_event.stream = sound_explosion
	sound_effects_event.play()
	train.current_speed += speed_extra_on_explosive_valve
	motor.health.damage(10, Vector2.ZERO)
	alert_finished()


# motor health
func _on_health_dead():
	sound_effects.stream = sound_breaking
	sound_effects.play()
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.GARAGE)


func get_difficult_multiplier():
	var difficult_multiplier = 0
	
	if train.current_distance > 300:
		difficult_multiplier = 1
	
	if train.current_distance > 800:
		difficult_multiplier = 2
		
	if train.current_distance > 1500:
		difficult_multiplier = 3
		
	if train.current_distance > 2500:
		difficult_multiplier = 4
		
	if train.current_distance > 3000:
		difficult_multiplier = 5
	
	return difficult_multiplier


func _on_health_health_update(old_value, new_value, damager_position):
	sound_effects.stream = sound_damage
	sound_effects.play()


func _on_train_distance_updated(_value):
	var distance_mark = get_difficult_multiplier()
	if distance_mark != current_distance_mark:
		current_distance_mark = distance_mark
		sound_effects.stream = sound_gate
		sound_effects.play()


func fuel_alert_started():
	sound_effects_event.stream = sound_fuel_leaking
	sound_effects_event.play()
	fuel_leaking_alert.show()
	valve_alert.hide()
	alert_started()
	
	
func valve_alert_started():
	fuel_leaking_alert.hide()
	valve_alert.show()
	alert_started()


func alert_started():
	alert_rect.show()
	alert_container.show()


func alert_finished():
	alert_rect.hide()
	alert_container.hide()


func _on_fuel_leaking_event_fail(event_name):
	alert_finished()
	sound_effects_event.stop()


func _on_explosive_valve_event_success(event_name):
	alert_finished()
	sound_effects_event.stop()
	
func _on_explosive_valve_2_event_success(event_name):
	alert_finished()
	
func _on_explosive_valve_3_event_success(event_name):
	alert_finished()
