extends GrabMechanism

var health = 6
var start_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	parent_minigame.game_success.connect(_on_game_success)

func _process(delta: float) -> void:
	
	
	if has_object:
		animation = "hand_closed"
	else:
		animation = "hand_open"
	frame = 6 - health

func _on_game_success() -> void:
	if grab_tween:
		grab_tween.kill()
	if frame != 2:
		frame = 0
	has_object = false
	retreat()

func grab_completed() -> void:
	has_object = true
	retreat()
	parent_minigame.apple_state_changed.emit(int(str(name)[-1]))
	

func retreated() -> void:
	super()
	if has_object:
		parent_minigame.lives -= 1
	health = 6

func _on_hand_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if active:
			if parent_minigame.hands_defeated >= 3:
				parent_minigame.hands_defeated = 0
				health -= 6
			else:
				health -= 1
			if health <= 0:
				parent_minigame.hands_defeated += 1
				if has_object:
					parent_minigame.apple_state_changed.emit(int(str(name)[-1]))
				frame = 1
				has_object = false
				retreat()
