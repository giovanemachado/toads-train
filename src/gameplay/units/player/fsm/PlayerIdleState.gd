extends State

class_name PlayerIdleState

@onready var state_manager: PlayerStateManager = $".."

func _on_enter():
	state_manager.animation_player.play("idle front")


func _on_physics_update(delta):
	if state_manager.player.velocity != Vector2.ZERO:
		Transitioned.emit(self, "PlayerRunState") 


func _on_attack_attacked():
	Transitioned.emit(self, "PlayerAttackState") 
