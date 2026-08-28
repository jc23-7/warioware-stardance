extends AnimatedSprite2D

@export var default_pos: Vector2
@export var goal_pos: Vector2

@onready var animation_player: AnimationPlayer = $"AnimationPlayer"
@onready var minigame_1: Node2D = $"../../"

var grab_apple_tween: Tween
var retreat_tween: Tween
var state = "inactive"
var has_apple = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = default_pos
	minigame_1.game_success.connect(_on_game_success)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_game_success() -> void:
	grab_apple_tween.kill()
	if frame != 2:
		frame = 0
	has_apple = false
	retreat()

func grab_apple() -> void:
	if not minigame_1.game_ended:
		frame = 0
		
		var distance = position.distance_to(goal_pos)
		var length = distance / 100.0
		
		grab_apple_tween = create_tween()
		grab_apple_tween.tween_property(self, "position", goal_pos, length)
		grab_apple_tween.finished.connect(apple_grabbed)

func apple_grabbed() -> void:
	frame = 1
	
	minigame_1.apple_state_changed.emit(int(str(name)[-1]))
	has_apple = true
	retreat()

func retreat() -> void:
	state = "retreating"
	if grab_apple_tween:
		grab_apple_tween.kill()
	var distance = position.distance_to(default_pos)
	var length = distance / 100.0

	retreat_tween = create_tween()
	retreat_tween.tween_property(self, "position", default_pos, length)
	retreat_tween.finished.connect(retreated)

func retreated() -> void:
	state = "inactive"
	if has_apple:
		minigame_1.completed_points -= 1

func _on_hand_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if state == "reaching":
			if has_apple:
				minigame_1.apple_state_changed.emit(int(str(name)[-1]))
			frame = 2
			has_apple = false
			retreat()
