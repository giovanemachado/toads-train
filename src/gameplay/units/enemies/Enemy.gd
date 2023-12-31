extends CharacterBody2D

class_name Enemy

signal enemy_die

@onready var health: Health = $Health

var pushback_force = Vector2.ZERO


func _on_health_dead():
	enemy_die.emit()


func knock_back(source_position: Vector2):
#	animation_player.play("hit")
	pushback_force = -global_position.direction_to(source_position) * 300
	
	
func _physics_process(delta: float):
	pushback_force = lerp(pushback_force, Vector2.ZERO, delta * 10)
	velocity = pushback_force
	move_and_slide()
