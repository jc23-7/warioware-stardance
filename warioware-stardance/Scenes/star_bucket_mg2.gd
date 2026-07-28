extends Area2D

@onready var minigame_2: Node2D = $".."
@onready var animation: AnimatedSprite2D = $"Animation"
@onready var frame = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_star_picked_up(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if minigame_2.star_picked_up:
			frame += 1
			animation.frame = frame
