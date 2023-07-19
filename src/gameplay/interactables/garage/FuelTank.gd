extends Upgrade

func _ready():
	garage_gameplay_manager = $"../../GameplayManager/GarageGameplayManager"
	super._ready()

func _on_interactable_player_interacted():
	if upgrade():
		upgrade_success.emit(upgrade_name)
	else:
		upgrade_fail.emit(upgrade_name)
