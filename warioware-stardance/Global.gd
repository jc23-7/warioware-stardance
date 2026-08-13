extends Node

var tutorial = false

signal scene_changed(new_scene_path)
var minigames_done = 0
var total_minigames = 3
var lives = 5

var current_constellation: Constellation
var timer_scene: String = "res://Scenes/timer_screen.tscn"
var end_scene: String = "res://Scenes/end_screen.tscn"
var level_scene: String = "res://Scenes/level_select.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_scene(next_scene_path: String) -> void:
	get_tree().change_scene_to_file(next_scene_path)
	scene_changed.emit(next_scene_path)
	
	if next_scene_path == "res://Scenes/title_scene.tscn":
		reset_game()


func reset_game() -> void:
	minigames_done = 0
	total_minigames = 3
	lives = 5


func start_constellation(constellation: Constellation) -> void:
	current_constellation = constellation
	minigames_done = 0
	get_tree().change_scene_to_file(timer_scene)

func next_minigame() -> void:
	get_tree().change_scene_to_packed(current_constellation.minigames[minigames_done])
	
	
func minigame_done(success: bool) -> void:
	if success:
		minigames_done += 1
	else:
		lives -= 1
	
	if minigames_done == current_constellation.minigames.size():
		get_tree().change_scene_to_file(level_scene)
	else:
		get_tree().change_scene_to_file(timer_scene)
	
