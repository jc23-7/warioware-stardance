extends Node2D

@onready var game_timer: Node2D = $GameTimer

var buttons_pressed = 0
var timer_end = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await game_timer.Timer(7.0)
	timer_end = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if buttons_pressed == 4:
		if Global.minigames_done > 3:
			get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/timer_screen.tscn")
			
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://Scenes/timer_screen.tscn")
