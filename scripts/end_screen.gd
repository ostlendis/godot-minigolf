extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/totalshots.text = str(GameState.total_shots)


func _on_playagain_pressed() -> void:
	GameState.restart_game()
