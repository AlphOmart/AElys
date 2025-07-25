extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

@onready var camera_pivot = $CameraPivot
@onready var player_pivot = $"."

var mouse_sensitivity = 0.005
var rotation_x = 0.0
var rotation_y = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_y -= event.relative.x * mouse_sensitivity
		rotation_x = clamp(rotation_x - event.relative.y * mouse_sensitivity, deg_to_rad(-45), deg_to_rad(45))
		camera_pivot.rotation = Vector3(rotation_x, 0, 0)
		player_pivot.rotation = Vector3(0, rotation_y, 0)

func _physics_process(delta):
	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	if Input.is_action_pressed("move_back"):
		input_dir.z += 1
	if Input.is_action_pressed("move_forward"):
		input_dir.z -= 1
	if Input.is_action_pressed("quit"):
		get_tree().quit()

	# Transformation de la direction selon la rotation du joueur
	var direction = (player_pivot.transform.basis * input_dir).normalized()

	# Vitesse horizontale
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Gravité
	if not is_on_floor():
		target_velocity.y -= fall_acceleration * delta
	else:
		target_velocity.y = 0.0  # reset si au sol

	# Déplacement
	velocity = target_velocity
	move_and_slide()
