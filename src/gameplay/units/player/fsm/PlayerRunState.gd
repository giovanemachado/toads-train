extends State

class_name PlayerRunState

@onready var state_manager: PlayerStateManager = $".."

func _on_enter():
	state_manager.animation_player.play("Run Right")


func _on_physics_update(delta):
	if state_manager.player.velocity == Vector2.ZERO:
		Transitioned.emit(self, "PlayerIdleState") 


func _on_attack_attacked():
	Transitioned.emit(self, "PlayerAttackState") 
