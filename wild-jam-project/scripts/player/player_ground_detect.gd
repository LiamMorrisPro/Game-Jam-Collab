extends Area2D
class_name ground_check_area

#keep list of colliders in ground check area so we can check if we are currently colliding
var collider_list = []


func _on_body_entered(body: Node2D) -> void:
    collider_list.append(body)


func _on_body_exited(body: Node2D) -> void:
    collider_list.erase(body)
