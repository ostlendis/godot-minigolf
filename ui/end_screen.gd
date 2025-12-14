extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/totalshots.text = str(GameState.total_shots)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed() -> void:
	GameState.restart_game()
