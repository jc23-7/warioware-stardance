extends Node2D

@onready var tutorial = false
@onready var game_timer: Node2D = $GameTimer
@onready var line_container: Node2D = $LineContainer
@onready var progress_label: RichTextLabel = $GameTimer/VBoxContainer/Progress

var lines_drawn = 0
var timer_end = false
var game_ended = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global.star_clicked.connect(_on_star_clicked)
	
	for line in line_container.get_children():
		line.hide()
	
	await game_timer.Timer(6.0)
	timer_end = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	progress_label.text = str(lines_drawn) + "/7"
	if lines_drawn == 7 and not game_ended:
		game_timer.display_time = false
		await game_timer.Timer(0.5)
		game_timer.display_time = true
		if Global.minigames_done >= Global.total_minigames:
			Global.change_scene("res://Scenes/end_screen.tscn")
		else:
			Global.change_scene("res://Scenes/timer_screen.tscn")
		
	elif timer_end:
		timer_end = false
		game_ended = true

		game_timer.timer.add_theme_color_override("default_color", Color.RED)
		
		GlobalAudio.stop_timer()
		await GlobalAudio.time_up()
		Global.minigames_done -= 1
		Global.lives -= 1
		Global.change_scene("res://Scenes/timer_screen.tscn")

func _on_star_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
