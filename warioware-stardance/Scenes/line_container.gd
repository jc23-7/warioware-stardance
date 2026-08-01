extends Node2D

@onready var minigame_3: Node2D = $".."

var state = 0
var line_start = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.star_clicked.connect(_on_star_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state == 1:
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			state = 0
			line_start = -1
		queue_redraw()

func _draw():
	if state == 1:
		var node_name = "../StarContainer/Star" + str(line_start)
		var star = get_node(node_name)
		draw_line(to_local(star.global_position), get_local_mouse_position(), Color.WHITE, 2.0)

func _on_star_clicked(star_id: int) -> void:
	if state == 0:
		state = 1
		line_start = star_id
	else:
		var node_name = "Line" + str(min(star_id, line_start)) + str(max(star_id, line_start))
		var line = get_node(node_name)
		if not line == null and not line.visible:
			minigame_3.lines_drawn += 1
			line.show()
			
			GlobalAudio.ding()
		state = 0
		line_start = -1
		queue_redraw()
