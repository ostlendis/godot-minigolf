extends RigidBody3D

@export var max_power: float = 40.0
@export var charge_speed: float = 10.0
@export var fall_reset_height: float = -5.0

var last_position: Vector3
var charging := false
var shot_power := 0.0
var camera: Camera3D

func _ready():
	camera = get_viewport().get_camera_3d()
	camera.connect("shoot", Callable(self, "_on_shoot"))
	last_position = global_transform.origin

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		sleeping = false
		apply_impulse(Vector3.ZERO, Vector3(10, 0, 0))
		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if is_still():
					charging = true
					shot_power = 0.0
			else:
				if charging:
					shoot_ball()
				charging = false

func _physics_process(delta):
	if is_still():
		linear_velocity = Vector3.ZERO
		angular_velocity = Vector3.ZERO
		if GameState.shots > 8:
			GameState.load_next_level()
		
	if charging:
		shot_power += charge_speed * delta
		shot_power = clamp(shot_power, 0.0, max_power)
		HUD.power_label.text = str(round(shot_power))
		# optional: print("Power:", shot_power)
	
	if global_transform.origin.y < fall_reset_height:
		reset_ball()

func reset_ball():
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	global_transform.origin = last_position
	

func shoot_ball():
	last_position = global_transform.origin
	var direction = -camera.global_transform.basis.z
	direction.y = 0
	direction = direction.normalized()
	print("Camera forward:", -camera.global_transform.basis.z)
	print("Direction used:", direction)
	print("Camera basis:", camera.global_transform.basis)
	
	GameState.shots += 1
	GameState.total_shots += 1

	apply_impulse(direction * shot_power/400)
	
func is_still():
	return (linear_velocity.length() < 0.03 and angular_velocity.length() < 0.8) or linear_velocity.length() < 0.005
