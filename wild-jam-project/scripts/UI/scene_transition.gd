extends CanvasLayer
class_name SceneTransition

@onready var color_rect: ColorRect = $ColorRect
@onready var aniplayer_transit: AnimationPlayer = $Transition

signal on_transition_finished


func _ready() -> void:
	color_rect.visible = false
	aniplayer_transit.animation_finished.connect(_on_animation_finished)

func Transition():
	color_rect.visible = true
	aniplayer_transit.play("fade_in")

func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		on_transition_finished.emit()
		aniplayer_transit.play("fade_out")
	elif anim_name == "fade_out":
		color_rect.visible = false
		
