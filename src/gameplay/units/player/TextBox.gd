extends Control

# Max chars
# Fuel leaking! How many text I can put here before it becomes pure shit??xx

@onready var text_box = $"."
@onready var text_label = $MarginContainer/MarginContainer2/Label
var tweener: Tween
var is_running = false


func _ready():
	tweener =  get_tree().create_tween()
	tweener.finished.connect(_on_tweener_finished)


func _physics_process(delta):
	if Input.is_action_just_pressed("player_interact"):
		if tweener.is_running():
			tweener.stop()
			text_label.visible_ratio = 1.0
		else:
			text_box.hide()


func show_text(text: String):
	text_label.text = text
	text_box.show()
	tweener.tween_property(text_label, "visible_ratio", 1.0, len(text) * 0.08)
	is_running = true


func _on_tweener_finished():
	is_running = false
