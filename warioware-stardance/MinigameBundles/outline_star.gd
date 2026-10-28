extends AnimatedSprite2D
class_name OutlineStar

@export var parent_minigame: Node
var id: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	id = int(str(name)[-1])
	parent_minigame.star_outline_activated.connect(_on_star_outline_activated)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_star_outline_activated(chosen_id: int) -> void:
	if id == chosen_id and not parent_minigame.game_ended:
		frame == 1
