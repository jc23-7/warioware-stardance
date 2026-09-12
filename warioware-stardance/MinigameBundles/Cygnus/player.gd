extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var parent_minigame: Node2D = $"../"

const SPEED_Y = 150
const SPEED_X = 100
const SINK_SPEED = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not parent_minigame.game_ended:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

		if direction.x:
			velocity.x = direction.x * SPEED_X
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED_X)

		if direction.y:
			velocity.y = direction.y * SPEED_Y
		else:
			velocity.y = move_toward(velocity.y, SINK_SPEED, SPEED_Y)
		move_and_slide()
		
		if position.x < 0:
			parent_minigame.lives -= 1
			death_animation()
	

func death_animation():
	var colour_tween = create_tween()
	for i in range(3):
		colour_tween.tween_property(animated_sprite, "modulate", Color(1, 1, 1, 1), 0.1)
		colour_tween.tween_property(animated_sprite, "modulate", Color(1, 0, 0, 1), 0.1)
