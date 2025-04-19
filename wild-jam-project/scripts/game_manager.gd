extends Node

@onready var transit: SceneTransition = $SceneTransition
const level_select = "res://UI/level_selector_screen.tscn"

#ui dependencies
@onready var minute_label: Label = $GameUI/Level_UI/ColorRect/HBoxContainer/minute_label
@onready var second_label: Label = $GameUI/Level_UI/ColorRect/HBoxContainer/second_label
@onready var msec_label: Label = $GameUI/Level_UI/ColorRect/HBoxContainer/msec_label

@onready var level_ui: Control = $GameUI/Level_UI
@onready var win_screen: Control = $GameUI/Win_Screen

#timer 
var time_taken : float
var minutes: int = 0
var seconds: int = 0
var msec: int = 0

var timer_on : bool = true

#doing it this way ensures that every level will have a mailbox, or you'll find out pretty quick that it doesn't
@export var mailbox: MailBox





#start a timer on level start
func _ready() -> void:
	Musicplayer.play_music_level()
	win_screen.visible = false
	level_ui.visible = true
	mailbox.parcel_delivered.connect(self.level_clear)

func _process(delta: float) -> void:
	
	
	if timer_on:
		time_taken += delta
		
		msec = fmod(time_taken, 1) * 100
		seconds = fmod(time_taken, 60) 
		minutes = fmod(time_taken, 3600) / 60
		minute_label.text = "%02d:" % minutes
		second_label.text = "%02d." % seconds
		msec_label.text = "%02d" % msec


func level_clear():
	print("cleared")
	timer_on = false
	win_screen.visible = true
	back_to_level_select()

func back_to_level_select():
	transit.Transition()
	await transit.on_transition_finished
	get_tree().change_scene_to_file(level_select)
