extends Node

@onready var life_bar: ProgressBar = $"../LifeBarTrain"
@onready var health: Health = $"../Health"

func _ready():
	life_bar.max_value = health.max_health_points
	life_bar.value = health.max_health_points


func _on_health_health_update(old_value, new_value, damager_position: Vector2):
	life_bar.value = new_value
