extends Node

signal shots_changed(new_value)
signal total_shots_changed(new_value)

var current_level := 0
var shots := 0:
	set(value):
		shots = value
		shots_changed.emit(shots)
		
var total_shots := 0:
	set(value):
		total_shots = value
		total_shots_changed.emit(total_shots)


var levels := [
	"res://levels/track_1.tscn",
	"res://levels/track_2.tscn",
	#"res://levels/track_3.tscn"
]

func reset_shots():
	shots = 0

func add_shot():
	shots += 1
	total_shots += 1

func restart_level():
	get_tree().change_scene_to_file(levels[current_level])
	reset_shots()

func load_next_level():
	current_level += 1
	if current_level >= levels.size():
		print("Game finished!")
		# load end screen
		get_tree().change_scene_to_file("res://ui/end_screen.tscn")
	else:
		print("Loading level:", current_level)
		get_tree().change_scene_to_file(levels[current_level])
		reset_shots()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
