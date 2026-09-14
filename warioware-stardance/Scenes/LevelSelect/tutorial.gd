extends SubViewportContainer

@export var level_info: Control

@onready var viewport: SubViewport = $MinigameViewport

var minigame_template: PackedScene
var minigame
var mouse_position:= Vector2.ZERO
var click := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_info.level_selected.connect(_on_level_selected)
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if level_info.selected_constellation and level_info.selected_constellation.unlocked:
		show()
		if viewport.get_child_count() != 0:
			var mouse_movement = InputEventMouseMotion.new()
			mouse_movement.position = mouse_position
			viewport.push_input(mouse_movement)
			
			if click:
				var mouse_click = InputEventMouseButton.new()
				mouse_click.button_index = MOUSE_BUTTON_LEFT
				mouse_click.pressed = true
				mouse_click.position = mouse_position
				viewport.push_input(mouse_click)
				click = false
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
	

func _exit_tree() -> void:
	for action in InputMap.get_actions():
		if action != "mute":
			Input.action_release(action)
	queue_free()
