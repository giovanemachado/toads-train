extends Node

@onready var train = $".."
@onready var life_bar: ProgressBar = $"../LifeBarTrain"
@onready var health: Health = $"../Health"

func _ready():
	health.max_health_points = train.current_resist
	life_bar.max_value = health.max_health_points
	life_bar.value = health.max_health_points


func _on_health_health_update(old_value, new_value, damager_position: Vector2):
	life_bar.value = new_value
