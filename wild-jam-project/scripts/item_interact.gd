extends Area2D

var items_in_reach : Array[RigidBody2D] = []
var throw_force = 1000.0


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and items_in_reach != []:
		_throw_items()


func _throw_items():
	for item in items_in_reach:
		item.apply_central_impulse(Vector2(0,-throw_force))
		pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Items"):
		items_in_reach.append(body)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Items"):
		items_in_reach.erase(body)
