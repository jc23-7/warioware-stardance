extends Node2D
@onready var game_timer: Node2D = $GameTimer

var collectable_collected = 0
var timer_end = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await game_timer.Timer(10.0)
	timer_end = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if collectable_collected == 1:
		if Global.minigamse_done > 3:
			get_tree().change_scene_to_file("res://scenes/end_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/timer_screen.tscn")
			
	if timer_end:
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/timer_screen.tscn")

func _on_node_2d_collectable_collected() -> void:
	collectable_collected += 1
	return
