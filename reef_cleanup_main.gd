# scripts/game/reef_cleanup_main.gd
extends Node3D

@onready var xr_origin: Node3D = $XROrigin3D
@onready var xr_camera: XRCamera3D = $XROrigin3D/XRCamera3D
@onready var pc_camera: Camera3D = $PcCamera

func _ready() -> void:
	_setup_xr_or_pc_mode()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _setup_xr_or_pc_mode() -> void:
	var xr_interface := XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("Running in XR mode")
		xr_origin.visible = true
		xr_camera.current = true
		pc_camera.current = false
		pc_camera.visible = false
	else:
		print("Running in PC mode")
		xr_origin.visible = false
		pc_camera.current = true
		pc_camera.visible = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
