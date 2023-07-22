extends StaticBody2D

var health: Health 
var b = false

func _process(delta):
	if !b:
		health = $"../../Motor/Health"
		b = true
