extends MeshInstance3D

@export var rotation_speed: float = 3.0  # radians per second
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_object_local(Vector3.FORWARD, rotation_speed * delta)
