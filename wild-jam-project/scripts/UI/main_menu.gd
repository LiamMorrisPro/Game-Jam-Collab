extends Control

@onready var volume: HSlider = $SettingsMenu/Volume
@onready var volume_label: Label = $SettingsMenu/VolumeLabel

var bus_index : int

var level_selector = preload("res://UI/level_selector_screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Global.change_cursor(0)
	
	volume.value = .5
	AudioServer.set_bus_volume_db(0, .5)
	
	$MainButtons.visible = true
	$CreditsMenu.visible = false
	$SettingsMenu.visible = false
	
	Musicplayer.play_music_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(level_selector)


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
	AudioServer.set_bus_volume_db(0,linear_to_db(value)) #zero is master bus
	
	value - db_to_linear(
		AudioServer.get_bus_volume_db(0)#master bus
	)
	

func _on_mute_toggled(toggled_on: bool) -> void:
	if toggled_on:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)


func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1980,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600,900))
		2:
			DisplayServer.window_set_size(Vector2i(1280,720))
