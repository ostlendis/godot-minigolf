extends Camera3D

@export var distance := 1.0
@export var height := 2.0
@export var rotate_speed := 0.003

var yaw := 0.0
var pitch := -0.2


signal shoot(power: float)

@export var max_power := 40.0
@export var charge_speed := 20.0

var charging := false
var shot_power := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		yaw -= event.relative.x * rotate_speed
		pitch += event.relative.y * rotate_speed
		pitch = clamp(pitch, -1.2, 0.2)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			charging = true
			shot_power = 0.0
		else:
			if charging:
				print("Shoot with power: ", shot_power)
				emit_signal("shoot", shot_power)
			charging = false

func _process(delta):
	var pivot := get_parent()

	# Calculate orbit offset
	var offset = Vector3(
		sin(yaw) * distance,
		height + pitch * 4.0,
		cos(yaw) * distance
	)

	global_position = pivot.global_position + offset
	look_at(pivot.global_position, Vector3.UP)

func _physics_process(delta):
	if charging:
		shot_power += charge_speed * delta
		shot_power = clamp(shot_power, 0.0, max_power)
