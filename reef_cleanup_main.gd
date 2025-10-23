# ReefCleanup_Main.gd
extends Node3D

func _ready():
	if XRServer.is_initialized():
		print("✅ XR Mode active")
	else:
		print("📱 Mobile/Desktop Mode active")
		var cam = Camera3D.new()
		cam.current = true
		cam.position = Vector3(0, 1.6, 3)
		add_child(cam)
