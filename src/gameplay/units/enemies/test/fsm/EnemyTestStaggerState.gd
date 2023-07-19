extends State

class_name EnemyTestStaggerState

@onready var state_manager: EnemyTestStateManager = $".."

func _on_health_stagger_recovered():
	Transitioned.emit(self, "EnemyTestChasingState")
