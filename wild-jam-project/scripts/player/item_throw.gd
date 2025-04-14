extends Area2D
class_name ItemThrow

var items_in_reach : Array[RigidBody2D] = []
var throw_force_up = 200.0
var throw_force_forward = 200.0

@onready var throw_timer: Timer = $throw_timer
var can_throw : bool = true

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("throw") and items_in_reach != [] and can_throw:
		can_throw = false
		throw_timer.start()
		_throw_items()


func _throw_items():
	for item in items_in_reach:
		item.apply_central_impulse(Vector2(throw_force_forward,-throw_force_up))
		pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Items"):
		items_in_reach.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Items"):
		items_in_reach.erase(body)


func _on_throw_timer_timeout() -> void:
	can_throw = true
