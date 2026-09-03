extends GrabMechanism

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	parent_minigame.game_success.connect(_on_game_success)


func _on_game_success() -> void:
	if grab_tween:
		grab_tween.kill()
	if frame != 2:
		frame = 0
	has_object = false
	retreat()

func grab_completed() -> void:
	super()
	parent_minigame.apple_state_changed.emit(int(str(name)[-1]))
	

func retreated() -> void:
	super()
	if has_object:
		parent_minigame.completed_points -= 1

func _on_hand_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if active:
			if has_object:
				parent_minigame.apple_state_changed.emit(int(str(name)[-1]))
			frame = 1
			has_object = false
			retreat()
