extends CharacterBody2D


@onready var collision_shape: CollisionShape2D = $"CollisionShape2D"
@onready var parent_minigame: Node2D = $".."
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150

var wait_time = 0.0
var size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = collision_shape.shape.extents * 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if parent_minigame.game_ended:
		velocity = Vector2.ZERO
		animated_sprite.stop()
	else:
		if wait_time <= 0.0:
			var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			if direction:
				velocity = direction * SPEED
				rotation = direction.angle()
				animated_sprite.play("walk")
			else:
				velocity = velocity.move_toward(Vector2.ZERO, SPEED)
				animated_sprite.play("default")
			
			move_and_slide()
		else:
			wait_time -= delta
			animated_sprite.stop()

func lose_life() -> void:
	parent_minigame.lives -= 1
	var colour_tween = create_tween()
	for i in range(3):
		colour_tween.tween_property(animated_sprite, "modulate", Color(1, 0, 0, 1), 0.1)
		colour_tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1, 1), 0.1)
	wait_time = 1.0
