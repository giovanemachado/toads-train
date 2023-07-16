extends CharacterBody2D

@onready var attack: Attack = $Attack
@onready var movement: Movement = $Movement
@onready var health: Health = $Health
@onready var interaction: Interaction = $Interaction

@onready var life_bar: ProgressBar = %LifeBar


func _ready():
	# isso pode ser null quando estamos na garage_scene
	if life_bar != null:
		life_bar.max_value = health.max_health_points
		life_bar.value = health.max_health_points
	
	
func _physics_process(delta):
	var input_vector = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	movement.movement(input_vector)


	if Input.is_action_just_pressed("player_attack"):
		attack.attack()


	if Input.is_action_just_pressed("player_interact"):
		interaction.interaction()


func _on_health_health_update(old_value, new_value):
	if life_bar != null:
		life_bar.value = new_value
