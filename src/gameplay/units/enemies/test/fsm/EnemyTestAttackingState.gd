extends State

class_name EnemyTestAttackingState

@onready var state_manager = $".."

var enemy_test: EnemyTest
var is_original_ready_done = false
var health: Health
var navigation_agent: NavigationAgent2D


func _on_update(_delta: float):
	if !is_original_ready_done:
		enemy_test = state_manager.enemy_test
		is_original_ready_done = true
		health = enemy_test.health
		navigation_agent = enemy_test.navigation_agent
		return
	
	if health.is_damaged:
		return
		
	enemy_test.attack.attack()
	navigation_agent.target_position = state_manager.player.position
	if navigation_agent.distance_to_target() > 100:
		Transitioned.emit(self, "EnemyTestChasingState") 
