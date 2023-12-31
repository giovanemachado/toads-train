extends Node

class_name GarageGameplayManager

@onready var gameplay_manager: GameplayManager = $".."

@onready var money_label = $"../../UI/Control/MarginContainer/VBoxContainer3/VBoxContainer/HBoxContainer2/Money"
@onready var distance_label = $"../../UI/Control/MarginContainer/VBoxContainer3/VBoxContainer/HBoxContainer/Distance"

@onready var player: Player = $"../../Player"
@onready var timer: Timer = $Timer
var lore_timing = 0.2
@onready var text_tutorial = $"../../Environment/Tutorial"

var random_phrases = [
	"Here we go again...",
	"One more time.",
	"I need to train more.",
	"Frogs...",
	"They drunk too much uranium, I think",
	"Where does this sword come from?"
]

func _ready():
	update_labels_debug()
	timer.start(lore_timing)


func _on_timer_timeout():
	if gameplay_manager.player_progress.garage_visited == 0:
		player.text_box.show_text("Damn it! I hate how frogs learned to think and hate trains.")
	
	if gameplay_manager.player_progress.garage_visited >= 1:
		text_tutorial.hide()
		player.text_box.show_text(random_phrases.pick_random())
	
	gameplay_manager.player_progress.garage_visited += 1


func _on_train_cabin_player_entered_in_cabin():
	gameplay_manager.change_scenes(Globals.MAIN_SCENES.TRAIN)


func update_labels_debug():
	money_label.text = "$" + str(gameplay_manager.player_progress.money)
	distance_label.text = str(gameplay_manager.player_progress.max_distance_reach)


func _on_player_update_combo(numb):
	pass


func _on_fuel_tank_upgrade_success(upgrade_name):
	update_labels_debug()


func _on_train_speed_upgrade_success(upgrade_name):
	update_labels_debug()
	
	

func _on_player_damage_upgrade_success(upgrade_name):
	update_labels_debug()
	
	
func _on_player_hp_upgrade_success(upgrade_name):
	update_labels_debug()
	

func _on_player_speed_upgrade_success(upgrade_name):
	update_labels_debug()
	

func _on_train_resistence_upgrade_success(upgrade_name):
	update_labels_debug()
