extends Node

@onready var life_bar: ProgressBar = %LifeBar
@onready var health: Health = $"../Health"

var tween: Tween


func _ready():
	life_bar.max_value = health.max_health_points
	life_bar.value = health.max_health_points


func _on_health_health_update(old_value, new_value, damager_position: Vector2):
	life_bar.value = new_value
	if tween:
		tween.kill()

	tween = create_tween()
	tween.tween_property(life_bar, "modulate", Color(1, 1, 1, 0), 0.2)
	tween.tween_property(life_bar, "modulate", Color(1, 1, 1, 1), 0.3)
