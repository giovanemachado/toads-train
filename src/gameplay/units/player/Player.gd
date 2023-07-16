extends CharacterBody2D

@onready var attack: Attack = $Attack
@onready var movement: Movement = $Movement
@onready var health: Health = $Health
@onready var interaction: Interaction = $Interaction

func _physics_process(delta):
	var input_vector = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	movement.movement(input_vector)


	if Input.is_action_just_pressed("player_attack"):
		attack.attack()


	if Input.is_action_just_pressed("player_interact"):
		interaction.interaction()
