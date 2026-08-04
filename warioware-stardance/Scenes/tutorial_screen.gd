extends Control

@export var mg1_move: float = 0.0

@export var mg2_mouse: Vector2
@export var mg3_mouse: Vector2

@export var minigame1_scene: PackedScene
@export var minigame2_scene: PackedScene
@export var minigame3_scene: PackedScene
@onready var viewport1 = $Minigame1Viewport
@onready var viewport2 = $Minigame2Viewport
@onready var viewport3 = $Minigame3Viewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if viewport1.get_child_count() != 0:
		viewport1.get_child(0).get_node("Player").fake_input.x = mg1_move
	if is_instance_valid(viewport2):
		var mouse_movement = InputEventMouseMotion.new()
		mouse_movement.position = mg2_mouse
		viewport2.push_input(mouse_movement)
	if is_instance_valid(viewport3):
		var mouse_movement = InputEventMouseMotion.new()
		mouse_movement.position = mg3_mouse
		viewport3.push_input(mouse_movement)

func reset_minigame() -> void:
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	
	for child in viewport1.get_children():
		child.queue_free()
	
	for child in viewport2.get_children():
		child.queue_free()
	
	for child in viewport3.get_children():
		child.queue_free()
	
	var minigame_1 = minigame1_scene.instantiate()
	viewport1.add_child(minigame_1)
	minigame_1.get_node("Player").tutorial = true
	
	var minigame_2 = minigame2_scene.instantiate()
	viewport2.add_child(minigame_2)
	
	var minigame_3 = minigame3_scene.instantiate()
	viewport3.add_child(minigame_3)
	minigame_3.tutorial = true

func press_key(key_name: String) -> void:
	Input.action_press(key_name)
	
func release_key(key_name: String) -> void:
	Input.action_release(key_name)
	
func click_star_spot(x: float, y: float) -> void:
	Global.star_spot_clicked.emit(x, y)

func click_bucket() -> void:
	Global.bucket_clicked.emit()

func click_star(star_id: int) -> void:
	Global.star_clicked.emit(star_id)

func _exit_tree() -> void:
	Input.action_release("ui_left")
	Input.action_release("ui_right")
