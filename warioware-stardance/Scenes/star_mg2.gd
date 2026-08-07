extends Node2D

@onready var state = 0
@onready var minigame_2 = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state == 1:
		global_position = get_global_mouse_position()

func _on_star_spot_clicked(x:float, y:float):
	if state == 1 and not minigame_2.game_ended:
		state = 2
		global_position = Vector2(x, y)
		minigame_2.stars_hung += 1
		minigame_2.star_picked_up = false
		
		GlobalAudio.shine()
