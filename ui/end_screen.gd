extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/totalshots.text = str(GameState.total_shots)
	


func _on_button_pressed() -> void:
	pass # Replace with function body.
