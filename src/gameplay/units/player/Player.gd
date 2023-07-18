extends CharacterBody2D

class_name Player

signal player_is_dead

signal update_combo(numb: int)

@onready var attack: Attack = $Attack
@onready var movement: Movement = $Movement
@onready var health: Health = $Health
@onready var interaction: Interaction = $Interaction
@onready var life_bar: ProgressBar = %LifeBar
@onready var sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = $Camera2D

var life_bar_is_ready = false

func _ready():
	# isso pode ser null quando estamos na garage_scene
	if !life_bar_is_ready && life_bar != null:
		life_bar.max_value = health.max_health_points
		life_bar.value = health.max_health_points
		life_bar_is_ready = true
	
	
func _physics_process(delta):
	var input_vector = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	movement.movement(input_vector)
	

	if Input.is_action_just_pressed("player_attack"):
		attack.attack()
		
	
	if Input.is_action_just_pressed("player_strong_attack"):
		attack.strong_attack()
	

	if Input.is_action_just_pressed("player_interact"):
		interaction.interaction()


func _on_health_health_update(old_value, new_value, damager_position: Vector2):
	if !life_bar_is_ready && life_bar != null:
		life_bar.max_value = health.max_health_points
		life_bar.value = health.max_health_points
		life_bar_is_ready = true

	if life_bar != null:
		life_bar.value = new_value


func _on_health_dead():
	player_is_dead.emit()


func _on_movement_turning_to(direction: int):
	sprite.flip_h = direction == 1


func _on_attack_attacked():
	camera.shake(0.20, 2.5)


func _on_player_attack_update_combo(numb):
	update_combo.emit(numb)

func _set_state():
	var state = "idle front"
