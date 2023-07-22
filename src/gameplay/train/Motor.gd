extends StaticBody2D

class_name Motor

@onready var train: Train = $"../Train"
@onready var health: Health = $Health
@onready var life_bar: ProgressBar = $"../../UI/Control/MarginContainer/HBoxContainer/MarginContainer2/VBoxContainer2/TrainLifeBar"

@onready var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	health.max_health_points = train.current_resist
	health.health_points = train.current_resist
	
	life_bar.max_value = health.max_health_points
	life_bar.value = health.max_health_points


func _on_health_health_update(old_value, new_value, damager_position):
	life_bar.value = new_value
	if tween:
		tween.kill()

	tween = create_tween()
	tween.tween_property(life_bar, "modulate", Color(1, 1, 1, 0), 0.2)
	tween.tween_property(life_bar, "modulate", Color(1, 1, 1, 1), 0.3)
