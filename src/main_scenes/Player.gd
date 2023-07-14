extends CharacterBody2D

@export var speed = 300.0

func _physics_process(delta):
	var input_vector = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	velocity = input_vector * speed
	
	move_and_slide()
