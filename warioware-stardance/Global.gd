extends Node

signal scene_changed(new_scene_path)
signal star_spot_clicked(x:float, y:float)
signal bucket_clicked
signal star_clicked (star: int)
var minigames_done = 0
var total_minigames = 3
var lives = 5

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
