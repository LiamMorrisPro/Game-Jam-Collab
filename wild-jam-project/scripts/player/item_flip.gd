extends Area2D
class_name ItemFlip

@onready var player: Player = $".."

var items_in_reach : Array[RigidBody2D] = []
@onready var flip_target: Marker2D = $Marker2D

@onready var flip_timer: Timer = $flip_timer

var can_flip = true

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("throw") and items_in_reach != [] and can_flip:
		can_flip = false
		flip_timer.start()
		_throw_items()


func _throw_items():
	for item in items_in_reach:
		item.linear_velocity = player.linear_velocity
		item.global_position = flip_target.global_position
		pass

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Items"):
		items_in_reach.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Items"):
		items_in_reach.erase(body)


func _on_flip_timer_timeout() -> void:
	can_flip = true
