extends State

class_name EnemyTestAttackingState

@onready var state_manager = $".."

var enemy_test: EnemyTest
var is_original_ready_done = false
var health: Health
var navigation_agent: NavigationAgent2D


func _on_enter():
	state_manager.animation_player.play("atk")


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


func _on_health_health_update(old_value, new_value, damager_position):
	Transitioned.emit(self, "EnemyTestStaggerState")


func _on_attack_attack_is_done():
	Transitioned.emit(self, "EnemyTestChasingState") 
