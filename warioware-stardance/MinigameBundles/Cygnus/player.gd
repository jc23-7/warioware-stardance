extends CharacterBody2D

@onready var collision_shape: CollisionPolygon2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var parent_minigame: Node2D = $"../"

const SPEED_Y = 150
const SPEED_X = 150
const SINK_SPEED = 25
const ROTATION_SPEED = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not parent_minigame.game_ended:
		var turning = Input.get_axis("ui_up", "ui_down")
		var direction = Input.get_axis("ui_left", "ui_right")
		
		rotation += turning * animated_sprite.scale.x * ROTATION_SPEED * delta
		rotation = clamp(rotation, deg_to_rad(-90), deg_to_rad(90))

		var forward_dir = Vector2.RIGHT.rotated(rotation)
		if direction:
			if direction < 0:
				animated_sprite.scale.x = -1
			elif direction > 0:
				animated_sprite.scale.x = 1
				
			velocity = forward_dir * direction * SPEED_X
			animated_sprite.speed_scale = 1.5
		else:
			animated_sprite.speed_scale = 1.0
			velocity.x = move_toward(velocity.x, 0, SPEED_X)
			velocity.y = move_toward(velocity.y, SINK_SPEED, SPEED_Y)

			
		move_and_slide()
		
		if position.x < -10:
			parent_minigame.lives -= 1
			death_animation()
	else:
		animated_sprite.stop()
	

func death_animation():
	var colour_tween = create_tween()
	for i in range(3):
		colour_tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1, 1), 0.1)
		colour_tween.tween_property(animated_sprite, "modulate", Color(1, 0, 0, 1), 0.1)
