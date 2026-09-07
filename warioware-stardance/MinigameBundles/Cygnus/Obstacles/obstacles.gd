extends AnimatableBody2D

@export var min_y: int
@export var max_y: int
@export var width: int
@export var collectible_scene: PackedScene

@onready var parent_minigame: Node2D = $"../../"

var can_spawn_next = false

const SPAWN_PROBABILITY = 0.5
const SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for child in get_children():
		if child is Marker2D:
			if randf() <= SPAWN_PROBABILITY:
				var collectible = collectible_scene.instantiate()
				collectible.position = child.position
				add_child(collectible)
				
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not parent_minigame.game_ended:
		global_position.x -= SPEED * delta
		if global_position.x + width <= get_viewport_rect().size.x:
			can_spawn_next = true
		if global_position.x < -width - 50:
			queue_free()
