extends Control


func _ready() -> void:
	$BlurFade.play("RESET")
	visible = false
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func _process(delta: float) -> void:
	pressedEsc()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")


func _on_levels_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/level_selector_screen.tscn")


func pause():
	get_tree().paused = true
	visible = true
	mouse_filter = Control.MOUSE_FILTER_STOP
	$BlurFade.play("blur")


func resume():
	get_tree().paused = false
	$BlurFade.play_backwards("blur")


func pressedEsc():
	if Input.is_action_just_pressed("esc"):
		if get_tree().paused:
			resume()
		else:
			pause()

# bassically hiding the  pause menu after the fade-out animation finishes
func _on_blur_fade_animation_finished(anim_name: StringName) -> void:
	if anim_name == "blur" and !get_tree().paused:
		visible = false
		mouse_filter = Control.MOUSE_FILTER_IGNORE
