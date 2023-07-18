extends State

class_name EnemyTestChasingState

@onready var state_manager: EnemyTestStateManager = $".."

var enemy_test: EnemyTest
var navigation_agent: NavigationAgent2D
var is_original_ready_done = false
var health: Health


func _on_update(_delta: float):
	if !is_original_ready_done:
		enemy_test = state_manager.enemy_test
		navigation_agent = enemy_test.navigation_agent
		is_original_ready_done = true
		health = enemy_test.health
		return

	if !enemy_test.agent_is_ready:
		return
	
	navigation_agent.target_position = state_manager.player.position
	
	if navigation_agent.distance_to_target() < 100:
		Transitioned.emit(self, "EnemyTestAttackingState") 

func _on_physics_update(delta):
	if !is_original_ready_done:
		return

	if health.is_damaged:
		return

	if navigation_agent.is_navigation_finished():
		return
	
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var current_agent_position: Vector2 = enemy_test.global_position
	var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized()
	
	enemy_test.movement.movement(new_velocity)


func _on_exit():
	enemy_test.movement.movement(Vector2.ZERO)


func _on_health_health_update(old_value, new_value, damager_position):
	Transitioned.emit(self, "EnemyTestStaggerState")
