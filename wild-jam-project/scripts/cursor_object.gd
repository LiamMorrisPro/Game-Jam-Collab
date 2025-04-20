extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const POINTER_NORMAL = preload("uid://ca5yw3sembx7")

const POINTER_PICK_UP_1 = preload("uid://drxb8wdf3hq5n")
const POINTER_THROW_1 = preload("uid://b32xynutqn3gw")
const POINTER_TOSS_1 = preload("uid://ciqla7ngyihqc")

var current_cursor : int = 0

func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	pass

func _process(delta: float) -> void:
	
	var global_cursor = Global.current_cursor
	if global_cursor != current_cursor:
		current_cursor = global_cursor
		match global_cursor:
			0: sprite_2d.texture = POINTER_NORMAL
			1: sprite_2d.texture = POINTER_TOSS_1
			2: sprite_2d.texture = POINTER_THROW_1
			3: sprite_2d.texture = POINTER_PICK_UP_1
	
	var mouse_pos = get_global_mouse_position()
	global_position = mouse_pos
	pass
