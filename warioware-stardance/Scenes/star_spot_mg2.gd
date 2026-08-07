extends Area2D


@onready var minigame_2 = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_event.connect(_on_input_event)
	Global.star_spot_clicked.connect(_on_star_spot_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if minigame_2.star_picked_up:
			Global.star_spot_clicked.emit(global_position.x, global_position.y)

func _on_star_spot_clicked(x: float, y:float) -> void:
	if global_position.x == x and global_position.y == y and not minigame_2.game_ended:
		hide()
