extends Node2D

class_name Interaction

var current_interactable: Node2D

func _on_area_2d_area_entered(area: Area2D):
	var area_parent = area.get_parent()
	
	if area_parent.is_in_group(Globals.INTERACTABLE_GROUP):
		current_interactable = area_parent
		current_interactable.in_player_range()


func _on_area_2d_area_exited(area: Area2D):
	var area_parent = area.get_parent()
	
	if area_parent == current_interactable:
		current_interactable.out_of_player_range()
		current_interactable = null


func interaction():
	if current_interactable != null:
		current_interactable.player_interact()
