extends Node2D

class_name Event

signal event_started(event_name: String)
signal event_success(event_name: String)
signal event_fail(event_name: String)

@onready var timer: Timer = $Timer
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@export_group("Event details")
@export var event_name: String
@export var event_timing: float
@export var kicks_to_solve: int
@onready var train_gm = $"../../GameplayManager/TrainGameplayManager"

var current_kicks: int = 0
var event_is_happening: bool = false

func start_event():
	timer.start(event_timing - train_gm.get_difficult_multiplier())
	current_kicks = 0
	event_started.emit(event_name)
	animationPlayer.play("event")
	event_is_happening = true


func tried_to_solve():
	if !event_is_happening:
		return
		
	current_kicks += 1
	
	if current_kicks >= kicks_to_solve:
		event_success.emit(event_name)
		timer.stop()
		animationPlayer.stop()
		event_is_happening = false
		

func _on_timer_timeout():
	if current_kicks >= kicks_to_solve:
		event_success.emit(event_name)
	else:
		event_fail.emit(event_name)
	
	event_is_happening = false
	animationPlayer.stop()
