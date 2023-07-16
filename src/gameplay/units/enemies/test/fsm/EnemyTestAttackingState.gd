extends State

class_name EnemyTestAttackingState

@onready var state_manager = $".."

var enemy_test: EnemyTest
var is_original_ready_done = false


func _on_update(_delta: float):
	if !is_original_ready_done:
		enemy_test = state_manager.enemy_test
		is_original_ready_done = true
		return
		
	enemy_test.attack.attack()
