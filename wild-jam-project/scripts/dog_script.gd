extends RigidBody2D


var detection_array = []



func tackle():
	pass

func raycast_detect():
	pass


func _on_detection_radius_body_entered(body: Node2D) -> void:
	detection_array.append(body)

func _on_detection_radius_body_exited(body: Node2D) -> void:
	detection_array.erase(body)
