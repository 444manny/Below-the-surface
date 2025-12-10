extends Node

signal score_changed(new_score: int)
signal goal_completed

var score: int = 0
@export var target_score: int = 200

func add_score(value: int) -> void:
	score += value
	emit_signal("score_changed", score)

	if score >= target_score:
		emit_signal("goal_completed")
