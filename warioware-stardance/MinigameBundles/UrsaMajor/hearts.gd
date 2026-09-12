extends Node2D

@onready var game_stats: Node2D = $"../../"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var num = 0
	for child in get_children():
		child.position.x = 25 + 40 * num
		num += 1
		child.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var num = 0
	for child in get_children():
		num += 1
		if num > game_stats.parent.lives:
			child.hide()
