extends RigidBody3D

signal collected

@export var score_value: int = 10

func collect() -> void:
	emit_signal("collected", score_value)
	queue_free()
