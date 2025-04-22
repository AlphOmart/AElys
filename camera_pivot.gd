extends Node3D

@onready var camera_pivot = $CameraPivot

var mouse_sensitivity = 0.005
var rotation_y = 0.0
var rotation_x = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_y -= event.relative.x * mouse_sensitivity
		#rotation_x -= event.relative.y * mouse_sensitivity
		rotation_x = clamp(rotation_x, deg_to_rad(-45), deg_to_rad(45))
		camera_pivot.rotation = Vector3(rotation_x, rotation_y, 0)
