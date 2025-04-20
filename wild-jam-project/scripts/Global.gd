extends Node

const POINTER_NORMAL_400 = preload("uid://damh0hrujpgq2")
const POINTER_PICK_UP_1_400 = preload("uid://btkxjh5xfwmuk")
const POINTER_THROW_1_400 = preload("uid://dyta2ftg0igc2")
const POINTER_TOSS_1_400 = preload("uid://bm736vheayd7h")

var level_clear : bool
var current_level : int

var levels := {
	1: {"completed": false, "time": -1.0},
	2: {"completed": false, "time": -1.0},
	3: {"completed": false, "time": -1.0}
}

var unlocked_levels = 1

func set_level_complete(level: int, time_taken: float) -> void:
	if levels.has(level):
		levels[level]["completed"] = true
		levels[level]["time"] = time_taken
		unlocked_levels = max(unlocked_levels, level + 1)

func is_level_unlocked(level_num: int) -> bool:
	return level_num <= unlocked_levels



var current_cursor : int = 0



func change_cursor(current_cursor : int):
	match current_cursor:
		0: Input.set_custom_mouse_cursor(POINTER_NORMAL_400)
		1: Input.set_custom_mouse_cursor(POINTER_TOSS_1_400)
		2: Input.set_custom_mouse_cursor(POINTER_THROW_1_400)
		3: Input.set_custom_mouse_cursor(POINTER_PICK_UP_1_400)
	pass
# 0 = regular pointer
# 1 = toss
# 2 = throw
# 3 = pickup
