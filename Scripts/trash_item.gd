extends RigidBody3D

@export var behavior: String = "float" # "float", "sink", or "static"
@export var buoyancy: float = 6.0
@export var water_drag: float = 2.0
@export var sink_speed: float = 0.5
@export var water_level: float = 0.0 # y-position of water surface

@onready var bottles := [
	$Plastic_Bottle_01_GEO,
	$Plastic_Bottle_02_GEO,
	$Plastic_Bottle_03_GEO
]

func _ready():
	randomize()

	# Hide all bottle meshes
	for b in bottles:
		b.visible = false

	# Show one random bottle mesh
	var selected = bottles[randi() % bottles.size()]
	selected.visible = true

	# Assign a random behavior
	var options = ["float", "sink", "static"]
	behavior = options[randi() % options.size()]

func _physics_process(delta: float) -> void:
	var current_height = global_transform.origin.y

	if behavior == "float":
		_apply_floating(delta, current_height)
	elif behavior == "sink":
		_apply_sinking(delta)
	# static = no physics modification

func _apply_floating(delta: float, h: float):
	if h < water_level:
		# Buoyancy pushes upward
		apply_central_force(Vector3.UP * buoyancy)

		# Add water drag
		linear_velocity *= (1.0 - delta * water_drag)

		# Slight bobbing
		apply_torque(Vector3(
			randf_range(-0.2, 0.2),
			randf_range(-0.1, 0.1),
			randf_range(-0.2, 0.2)
		))

func _apply_sinking(delta: float):
	# Slowly move downward
	apply_central_force(Vector3.DOWN * sink_speed)
