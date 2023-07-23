extends State

class_name EnemyTestChasingState

@onready var state_manager: EnemyTestStateManager = $".."

var enemy_test: EnemyTest
var navigation_agent: NavigationAgent2D
var is_original_ready_done = false
var health: Health
var attack: Attack
var is_in_train = false
var chasing_animation = "falling"


func _on_enter():
	state_manager.animation_player.play(chasing_animation)
	
	if is_original_ready_done:
		enemy_test.audio_player_walk.play()
	


func _on_update(_delta: float):
	if !is_original_ready_done:
		enemy_test = state_manager.enemy_test
		navigation_agent = enemy_test.navigation_agent
		is_original_ready_done = true
		health = enemy_test.health
		attack = enemy_test.attack
		enemy_test.audio_player_parachute.play()
		
		if state_manager.target == null:
			var nodes_in_attack_group = get_tree().get_nodes_in_group(attack.attack_group)
			var nodes_to_attack = nodes_in_attack_group.filter(func(n): return n is Event || n is Player || n is Motor)
			state_manager.target = nodes_to_attack.pick_random()
			
		health.can_be_attacked(false)
		return

	if !enemy_test.agent_is_ready:
		return
	
	navigation_agent.target_position = state_manager.target.position
	
	if navigation_agent.distance_to_target() < 70 && is_in_train:
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


func _on_area_2d_area_entered(area):
	if !area.is_in_group("detect_train"):
		return

	if is_in_train:
		return
	
	enemy_test.audio_player_parachute.stop()
	enemy_test.audio_player_walk.play()
	health.can_be_attacked(true)
	chasing_animation = "run"
	is_in_train = true
	state_manager.animation_player.play(chasing_animation)
