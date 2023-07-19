extends ParallaxLayer

@onready var train = $"../../Train"
var auto_moving_speed = 0
var multiplier_visual_movement = 2

func _ready():
	auto_moving_speed = train.current_speed * multiplier_visual_movement

func _process(delta):
	motion_offset.x += auto_moving_speed * delta
