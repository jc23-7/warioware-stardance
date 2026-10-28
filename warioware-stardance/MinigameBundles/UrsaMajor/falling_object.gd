extends Node2D

var vertical_speed: float
var horizontal_speed: float
var player: CharacterBody2D
var parent_minigame: Node2D
var hit_player: bool = false
var x_to_player: float
var min_hit_y: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	position.x = randf_range(0, 480-100)
	position.y = -100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not parent_minigame.game_ended:
		if not hit_player:
			position.x += horizontal_speed
			position.y += vertical_speed
			rotation = Vector2(horizontal_speed, vertical_speed).angle() - PI/2.0
			if position.y > get_window().size.y + 100:
				queue_free()
			elif $AnimatedSprite2D/Area2D.overlaps_body(player) and global_position.y < min_hit_y:
				parent_minigame.lives -= 1
				hit_player = true
				x_to_player = (position.x - player.position.x) * player.visuals.scale.x
		else:
			position.x = player.position.x + x_to_player * player.visuals.scale.x
		
