extends Sprite2D


@onready var parent_minigame: Node2D = $"../"
@export var move_speed: int

var move_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	parent_minigame.active_dragon_changed.connect(move_star)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if parent_minigame.has_star:
		show()
		if not parent_minigame.star_moving:
			position = parent_minigame.dragons[parent_minigame.active_dragon_num].position
	else:
		hide()

func move_star(start_id: int, end_id: int) -> void:
	move_tween = create_tween()
	var start_pos = parent_minigame.dragons[start_id].position
	var end_pos = parent_minigame.dragons[end_id].position
	var distance = start_pos.distance_to(end_pos)
	var length = distance / move_speed

	move_tween.tween_property(self, "position", end_pos, length)
	move_tween.finished.connect(parent_minigame.change_active_dragon.bind(end_id))
