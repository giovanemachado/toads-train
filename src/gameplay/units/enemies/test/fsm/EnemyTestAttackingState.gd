extends State

class_name EnemyTestAttackingState

@onready var state_manager = $".."

var enemy_test: EnemyTest
var is_original_ready_done = false
var health: Health


func _on_update(_delta: float):
	if !is_original_ready_done:
		enemy_test = state_manager.enemy_test
		is_original_ready_done = true
		health = enemy_test.health
		return
	
	if health.is_damaged:
		return
		
	enemy_test.attack.attack()
