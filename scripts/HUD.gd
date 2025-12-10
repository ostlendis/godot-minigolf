extends CanvasLayer
@onready var power_label : Label = $Control/PowerLabel
@onready var level_shot_count_label : Label = $Control/TrackShotCountLabel
@onready var total_shot_count_label : Label = $Control/TotalShotCountLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.shots_changed.connect(_on_shots_changed)
	_on_shots_changed(GameState.shots)
	
	GameState.total_shots_changed.connect(_on_total_shots_changed)
	_on_total_shots_changed(GameState.total_shots)

func _on_shots_changed(new_value):
	level_shot_count_label.text = str(new_value)
	
func _on_total_shots_changed(new_value):
	total_shot_count_label.text = str(new_value)
