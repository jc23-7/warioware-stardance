extends Node2D

@export var heart_template: PackedScene
@onready var game_stats: Node2D = $"../../"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await game_stats.ready
	if game_stats.display_lives:
		for i in range(game_stats.parent.lives):
			var new_heart = heart_template.instantiate()
			add_child(new_heart)
			new_heart.position.x = 25 + 30 * i
			new_heart.global_position.y = position.y
			new_heart.frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_stats.display_lives:
		var num = 0
		for child in get_children():
			num += 1
			if num > game_stats.parent.lives:
				child.frame = 1
			else:
				child.frame = 0
