extends StaticBody2D

@onready var train: Train = $"../Train"
@onready var health: Health = $Health
@onready var life_bar: ProgressBar = $"../../UI/Control/MarginContainer/VBoxContainer/TrainLifeBar"

# Called when the node enters the scene tree for the first time.
func _ready():
	health.max_health_points = train.current_resist
	
	life_bar.max_value = health.max_health_points
	life_bar.value = health.max_health_points


func _on_health_health_update(old_value, new_value, damager_position):
	life_bar.value = new_value
