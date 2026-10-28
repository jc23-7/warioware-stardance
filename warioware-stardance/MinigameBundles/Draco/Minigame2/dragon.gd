extends GrabMechanism

var stars_left = 2
var dragon_num

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	dragon_num = int(str(name)[-1])

func _process(delta: float) -> void:
	if parent_minigame.active_dragon_num == dragon_num - 1:
		if frame != 2:
			frame = 1
	else:
		frame = 0

func grab_completed() -> void:
	super()
	if stars_left == 0:
		frame = default_frame
		parent_minigame.has_star = false
	else:
		parent_minigame.has_star = true
		stars_left -= 1
		parent_minigame.star_state_changed.emit(dragon_num)
