extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BlurFade.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
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



func resume():
	get_tree().paused = false
	$BlurFade.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$BlurFade.play("blur")


func pressedEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()
