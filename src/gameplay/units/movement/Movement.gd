extends Node2D

class_name Movement

signal turning_to # 0 left 1 right

@onready var character: CharacterBody2D = $".."
@export var speed: float = 300.0
@export var aceleration: float = 10.8
@export var friction: float = 1000.6

var current_direction = 0 # 0 left 1 right

func movement(input_vector: Vector2):
	character.velocity = input_vector * speed
	
	if character.velocity.x > 0.01 && current_direction == 0:
		current_direction = 1
		turning_to.emit(current_direction)
	
	if character.velocity.x < -0.01 && current_direction == 1:
		current_direction = 0
		turning_to.emit(current_direction)
		
	#if character.velocity != Vector2.ZERO:
		#character.velocity.x = lerp(character.velocity.x, input_vector.x * speed, aceleration)
		#character.velocity.y = lerp(character.velocity.y, input_vector.y * speed, aceleration)
		#return
	
	#character.velocity.x = lerp(character.velocity.x, input_vector.x * speed, friction)
	#character.velocity.y = lerp(character.velocity.y, input_vector.y * speed, friction)
	
	character.move_and_slide()
