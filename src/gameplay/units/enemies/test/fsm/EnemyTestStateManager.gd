extends StateManager

class_name EnemyTestStateManager

@onready var enemy_test: EnemyTest  = $".."
@onready var player: Player = get_tree().get_first_node_in_group(Globals.PLAYER_GROUP)
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
var target
