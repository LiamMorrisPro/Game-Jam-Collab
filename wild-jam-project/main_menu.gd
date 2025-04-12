extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    $MainButtons.visible = true
    $CreditsMenu.visible = false
    $SettingsMenu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_start_pressed() -> void:
    pass # Replace with function body.


func _on_options_pressed() -> void:
    $MainButtons.visible = false
    $SettingsMenu.visible = true


func _on_quit_pressed() -> void:
    get_tree().quit()


func _on_credits_pressed() -> void:
    $MainButtons.visible = false
    $CreditsMenu.visible = true


func _on_back_pressed() -> void:
    $MainButtons.visible = true
    $CreditsMenu.visible = false
    $SettingsMenu.visible = false


#func _on_full_screen_toggled(toggled_on: bool) -> void:
    #if !toggled_on:
        #DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
    #else:
        #DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)


func _on_volume_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(0,value)


func _on_mute_toggled(toggled_on: bool) -> void:
    pass # Replace with function body.


func _on_resolutions_item_selected(index: int) -> void:
    match index:
        0:
            DisplayServer.window_set_size(Vector2i(1920,1080))
        1:
            DisplayServer.window_set_size(Vector2i(1600,900))
        2:
            DisplayServer.window_set_size(Vector2i(1280,720))
