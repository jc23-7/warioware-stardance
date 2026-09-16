extends SubViewportContainer

@export var level_info: Control

@onready var viewport: SubViewport = $MinigameViewport
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var minigame_template: PackedScene
var minigame
var current_mouse_pos := Vector2.ZERO
var mouse_move_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_info.level_selected.connect(_on_level_selected)
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if level_info.selected_constellation and level_info.selected_constellation.unlocked and level_info.tab == $"../":
		show()
		animation_player.play(level_info.selected_constellation.constellation_name)
	else:
		hide()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		get_viewport().set_input_as_handled()

func _on_level_selected(constellation_name: String):
	Global.tutorial = true
	for constellation in Global.constellations:
		if constellation.constellation_name == constellation_name:
			minigame_template = constellation.minigame
			break
	
	reset_minigame()
	show()

func click_mouse(mouse_pos: Vector2) -> void:
	var mouse_click = InputEventMouseButton.new()
	mouse_click.button_index = MOUSE_BUTTON_LEFT
	mouse_click.pressed = true
	mouse_click.position = mouse_pos
	mouse_click.global_position = mouse_pos
	viewport.push_input(mouse_click)
	
func move_mouse(mouse_pos: Vector2) -> void:
	mouse_move_tween = create_tween()
	mouse_move_tween.tween_method(update_mouse, current_mouse_pos, mouse_pos, 0.5)
	
func update_mouse(mouse_pos: Vector2) -> void:
	var mouse_movement = InputEventMouseMotion.new()
	mouse_movement.position = mouse_pos
	viewport.push_input(mouse_movement)
	

func reset_minigame() -> void:
	for action in InputMap.get_actions():
		if action != "mute":
			Input.action_release(action)
	
	for child in viewport.get_children():
		child.queue_free()

	minigame = minigame_template.instantiate()
	viewport.add_child(minigame)

func press_key(key_name: String) -> void:
	Input.action_press(key_name)
	
func release_key(key_name: String) -> void:
	Input.action_release(key_name)
	
func activate_draco_hand(hand_id: int) -> void:
	minigame.grab_apple(hand_id)

func damage_draco_hand(hand_id: int) -> void:
	minigame.hands_list[hand_id].take_damage()

func _exit_tree() -> void:
	for action in InputMap.get_actions():
		if action != "mute":
			Input.action_release(action)
	queue_free()
