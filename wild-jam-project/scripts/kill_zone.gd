extends Area2D
class_name KillZone


var restart = func (): get_tree().reload_current_scene()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") || body.is_in_group("Items"):
		if Global.level_clear == false:
			restart.call_deferred()
