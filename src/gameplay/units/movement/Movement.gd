extends Node2D

class_name Movement

@onready var character: CharacterBody2D = $".."
@export var speed = 300.0

func movement(input_vector: Vector2):
	character.velocity = input_vector * speed
	character.move_and_slide()
