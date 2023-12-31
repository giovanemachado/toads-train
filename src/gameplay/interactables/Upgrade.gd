extends Node2D

class_name Upgrade

signal upgrade_success(upgrade_name: String)
signal upgrade_fail(upgrade_name: String)

@export var upgrade_name: String
@export var cost_to_upgrade_by_level: Array[int] = [10]
@export var upgrade_amount_by_level:  Array[int] = [10]
@export var max_level: int = 1
@onready var audio_stream_player = $"../AudioStreamPlayer"
var sound_no_money = preload("res://src/gameplay/audios/othersounds/soudnegative.mp3")
var sound_money = preload("res://src/gameplay/audios/othersounds/cashregister.mp3")

var current_level: int = 0
var garage_gameplay_manager: GarageGameplayManager

@onready var label_cost = $MarginContainer/MarginContainer2/VBoxContainer/Cost


func _ready():
	var costs_count = cost_to_upgrade_by_level.size()
	var amounts_count = upgrade_amount_by_level.size()
	current_level = garage_gameplay_manager.gameplay_manager.player_progress[upgrade_name + "_level"]
	
	if current_level >= max_level:
		label_cost.text = "MAX LEVEL"
	else:
		label_cost.text = "Cost: $" + str(cost_to_upgrade_by_level[current_level])
		
	assert(costs_count > 0, "No costs declared. Upgrade name: " + upgrade_name)
	assert(amounts_count > 0, "No upgrade amounts declared. Upgrade name: " + upgrade_name)
	assert(costs_count == amounts_count, "Levels and amounts are different. Upgrade name: " + upgrade_name)
	assert(garage_gameplay_manager != null, "garage_gameplay_manager is not ready. Upgrade name: " + upgrade_name)
	assert(max_level == costs_count, "Max level is bigger than upgrades avaiable. Upgrade name: " + upgrade_name)


func upgrade():
	if current_level >= max_level:
		audio_stream_player.stream = sound_no_money
		audio_stream_player.play()
		return false
	
	var current_cost = cost_to_upgrade_by_level[current_level]
	var current_amount = upgrade_amount_by_level[current_level]

	if garage_gameplay_manager.gameplay_manager.player_progress.money < current_cost:
		audio_stream_player.stream = sound_no_money
		audio_stream_player.play()
		return false

	garage_gameplay_manager.gameplay_manager.player_progress[upgrade_name] += current_amount
	garage_gameplay_manager.gameplay_manager.player_progress.money -= current_cost
	garage_gameplay_manager.gameplay_manager.player_progress[upgrade_name + "_level"] += 1

	current_level += 1
	
	if current_level >= max_level:
		label_cost.text = "MAX LEVEL"
	else:
		label_cost.text = "Cost: $" + str(cost_to_upgrade_by_level[current_level])
	
	audio_stream_player.stream = sound_money
	audio_stream_player.play()
	return true
