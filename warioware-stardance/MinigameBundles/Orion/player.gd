extends CharacterBody2D


@onready var collision_shape: CollisionShape2D = $"CollisionShape2D"

const SPEED = 250

var size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = collision_shape.shape.extents * 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	
	move_and_slide()
