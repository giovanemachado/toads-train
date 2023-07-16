extends Node2D

class_name Movement

signal turning_to # 0 left 1 right

@onready var character: CharacterBody2D = $".."
@export var speed = 300.0

var current_direction = 0 # 0 left 1 right

func movement(input_vector: Vector2):
	character.velocity = input_vector * speed
	
	if character.velocity.x > 0.01 && current_direction == 0:
		current_direction = 1
		turning_to.emit(current_direction)
	
	if character.velocity.x < -0.01 && current_direction == 1:
		current_direction = 0
		turning_to.emit(current_direction)
		
	
	character.move_and_slide()
