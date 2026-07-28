extends Node2D

@onready var game_timer: Node2D = $GameTimer
@onready var line_container: Node2D = $LineContainer
@onready var progress_label: RichTextLabel = $GameTimer/VBoxContainer/Progress

var lines_drawn = 0
var timer_end = false

#var state = 0
#var line_start = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global.star_clicked.connect(_on_star_clicked)
	
	for line in line_container.get_children():
		line.hide()
	
	await game_timer.Timer(20.0)
	timer_end = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	progress_label.text = str(lines_drawn) + "/7"
	if lines_drawn == 7:
		await game_timer.Timer(0.5)
		if Global.minigames_done > 3:
			Global.change_scene("res://scenes/end_screen.tscn")
		else:
			Global.change_scene("res://Scenes/timer_screen.tscn")
			
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -= 1
		Global.change_scene("res://Scenes/timer_screen.tscn")

#func _on_star_clicked(star_id: int) -> void:
	#if state == 0:
		#state = 1
		#line_start = star_id
	#else:
		#if star_id == line_start + 1 or star_id == line_start - 1 or (star_id == 7 and line_start == 4) or (star_id == 4 and line_start == 7):
			#var node_name = "LineContainer/Line" + str(min(star_id, line_start)) + str(max(star_id, line_start))
			#var line = get_node(node_name)
			#if not line == null and not line.visible:
				#lines_drawn += 1
				#line.show()
		#state = 0
		#line_start = -1


func _on_star_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
