extends Node3D

@export var trash_scene: PackedScene
@export var spawn_range_x: float = 40.0
@export var spawn_range_z: float = 40.0
@export var min_height: float = -1.5
@export var max_height: float = 1.5
@export var max_trash: int = 20
@export var spawn_interval: float = 3.0

var _timer: float = 0.0

func _process(delta: float) -> void:
	_timer += delta
	if _timer >= spawn_interval:
		_timer = 0.0
		if get_child_count() < max_trash:
			_spawn_trash()

func _spawn_trash() -> void:
	if trash_scene == null:
		return

	var trash := trash_scene.instantiate()

	# Random spawn offsets
	var x = randf_range(-spawn_range_x, spawn_range_x)
	var z = randf_range(-spawn_range_z, spawn_range_z)
	var y = randf_range(min_height, max_height)

	trash.position = global_position + Vector3(x, y, z)
	add_child(trash)
