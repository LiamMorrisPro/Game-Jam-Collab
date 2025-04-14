extends Camera2D

@export var follow_target : Player
var follow_speed = 3

func _process(delta: float) -> void:
	position.x = lerp(position.x, follow_target.position.x, delta * follow_speed)
