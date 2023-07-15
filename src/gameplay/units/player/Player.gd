extends CharacterBody2D

@onready var attack: Attack = $Attack
@onready var movement: Movement = $Movement
@onready var health: Health = $Health

func _physics_process(delta):
	var input_vector = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	movement.movement(input_vector)
	
	if Input.is_action_pressed("player_attack"):
		attack.attack()
