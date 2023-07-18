extends State

class_name PlayerAttackState

@onready var state_manager: PlayerStateManager = $".."

func _on_enter():
	state_manager.animation_player.play("atk right")


func _on_attack_attack_is_done():
	Transitioned.emit(self, "PlayerIdleState") 
