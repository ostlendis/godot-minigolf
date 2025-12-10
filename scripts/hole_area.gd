extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.

func _on_body_entered(body):
	if body.is_in_group("ball"):
		print("ball in hole")
		GameState.load_next_level()
