extends Node2D
class_name MailBox


signal parcel_delivered




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Items"):
		parcel_delivered.emit()
		pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
