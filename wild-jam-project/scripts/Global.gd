extends Node


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
