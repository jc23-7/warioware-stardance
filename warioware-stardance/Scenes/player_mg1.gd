extends CharacterBody2D

@export var tutorial: bool = false
var fake_input: Vector2 = Vector2.ZERO

@onready var visuals: Node2D = $"Visuals"
@onready var animated_sprite: AnimatedSprite2D = $"Visuals/AnimatedSprite"

const SPEED = 250.0
const JUMP_VELOCITY = -500.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	
	var direction
	if tutorial:
		direction = fake_input.x
	else:
		direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		if direction < 0:
			visuals.scale.x = -1
			
		elif direction > 0:
			visuals.scale.x = 1
		velocity.x = direction * SPEED
		animated_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	move_and_slide()
