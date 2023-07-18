extends State

class_name EnemyTestStaggerState

@onready var state_manager: EnemyTestStateManager = $".."
@onready var effects: AnimationPlayer = $"../../Effects"


func _on_enter():
	effects.play("stagger")


func _on_health_stagger_recovered():
	Transitioned.emit(self, "EnemyTestChasingState")


func _on_health_health_update(old_value, new_value, damager_position):
	effects.play("stagger")
