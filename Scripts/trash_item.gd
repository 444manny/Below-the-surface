extends RigidBody3D

@export var lifespan: float = 30.0    # auto-despawn
@export var slow_damp_min: float = 3.0
@export var slow_damp_max: float = 6.0

var lifetime := 0.0
var mesh_list: Array = []


func _ready():
	randomize()

	lifetime = lifespan

	# ----------------------------------
	# 1. Collect all mesh children
	# ----------------------------------
	mesh_list.clear()
	for child in get_children():
		if child is MeshInstance3D:
			mesh_list.append(child)
			child.visible = false  # hide all at start

	# ----------------------------------
	# 2. Pick ONE random bottle mesh
	# ----------------------------------
	if mesh_list.size() > 0:
		var chosen = mesh_list[randi() % mesh_list.size()]
		chosen.visible = true

	# ----------------------------------
	# 3. Slow movement + no spinning
	# ----------------------------------
	linear_damp = randf_range(slow_damp_min, slow_damp_max)
	angular_damp = 10.0
	freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	freeze = false


func _physics_process(delta):
	# ----------------------------------
	# 4. Auto-despawn
	# ----------------------------------
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
