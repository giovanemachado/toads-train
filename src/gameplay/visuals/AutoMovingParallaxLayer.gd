extends ParallaxLayer

@export var auto_moving_speed = 15

func _process(delta):
	motion_offset.x += auto_moving_speed * delta
