extends StateManager

class_name EnemyTestStateManager

@onready var enemy_test: EnemyTest  = $".."
@onready var player: Player = get_tree().get_nodes_in_group(Globals.PLAYER_GROUP)[0]
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
