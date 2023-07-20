extends Node

@onready var train: Train = $"../Train"
@onready var timer: Timer = $Timer
@export var events: Array[Event] = []
@export var events_cooldown: float = 10
@export var timing_to_first_event: float = 10
@onready var train_gameplay_manager = $"../../GameplayManager/TrainGameplayManager"

func _ready():
	timer.start(timing_to_first_event)

func start_events():
	var difficult_multiplier = train_gameplay_manager.get_difficult_multiplier()
	
	var random_event = events.pick_random()
	
	random_event.start_event()
	var next_event_timing = random_event.event_timing + events_cooldown + (randf_range(-10.0, 10.0)) - difficult_multiplier
	
	if next_event_timing < 2:
		next_event_timing = 2
		
	timer.start(next_event_timing)

func _on_timer_timeout():
	start_events()
