# DO NOT USE THIS DIRECTLY, CREATE A NEW FILE AND EXTEND IT
extends Node

class_name StateManager

@export var initial_state : State

var current_state : State
var states: Dictionary = {}


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state._on_enter()
		current_state = initial_state


func _process(delta):
	if current_state:
		current_state._on_update(delta)


func _physics_process(delta):
	if current_state:
		current_state._on_physics_update(delta)


func on_child_transition(state: State, new_state_name: String):
	if state != current_state && current_state != null:
		return
		
	var new_state : State = states.get(new_state_name.to_lower())

	if !new_state:
		return
	
	if current_state:
		current_state._on_exit()
	
	current_state = new_state
	new_state._on_enter()
