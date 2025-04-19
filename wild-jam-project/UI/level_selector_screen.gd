extends Control

@export var transit : SceneTransition

var Level_1 = preload("res://Levels/Level_1.tscn")
var Level_2 = preload("res://Levels/Level_2.tscn")
var Level_3 = preload("res://Levels/Level_3.tscn")

@onready var level_1_button: Button = $Hbox/Level_1_Button
@onready var level_2_button: Button = $Hbox/Level_2_Button
@onready var level_3_button: Button = $Hbox/Level_3_Button





func _ready() -> void:
	level_1_button.disabled = !Global.is_level_unlocked(1)
	level_2_button.disabled = !Global.is_level_unlocked(2)
	level_3_button.disabled = !Global.is_level_unlocked(3)

func _on_level_1_button_pressed() -> void:
	Global.current_level = 1
	transit.Transition()
	await transit.on_transition_finished
	Musicplayer.fade_in_music()
	get_tree().change_scene_to_packed(Level_1)


func _on_level_2_button_pressed() -> void:
	Global.current_level = 2
	if !Global.is_level_unlocked(2): return
	transit.Transition()
	await transit.on_transition_finished
	Musicplayer.fade_in_music()
	get_tree().change_scene_to_packed(Level_2)


func _on_level_3_button_pressed() -> void:
	Global.current_level = 3
	if !Global.is_level_unlocked(3): return
	transit.Transition()
	await transit.on_transition_finished
	Musicplayer.fade_in_music()
	get_tree().change_scene_to_packed(Level_3)
