extends CharacterBody2D

@onready var parent_minigame = $"../"
@onready var player = $"../Player"

const CHASE_SPEED = 100.0
const CHARGE_SPEED = 500.0

enum State {CHASE, CHARGE, RECOVER}
var current_state = State.CHASE
var charge_dir = Vector2.ZERO
var wait_time := 0.0

func _physics_process(delta: float) -> void:
	print(current_state)
	if current_state == State.CHASE:
		chase()
	elif current_state == State.CHARGE:
		if wait_time <= 0:
			if charge_dir == Vector2.ZERO:
				charge_dir = position.direction_to(player.position).normalized()
			charge()
		else:
			wait_time -= delta
			velocity = Vector2.ZERO
	elif current_state == State.RECOVER:
		velocity = Vector2.ZERO
		wait_time -= delta
		if wait_time <= 0:
			current_state = State.CHASE

	move_and_slide()
	
	if current_state == State.CHARGE:
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			if collision.get_collider() is CharacterBody2D:
				parent_minigame.lives -= 1
			current_state = State.RECOVER
			wait_time = 2.0

func chase() -> void:
	var direction = position.direction_to(player.position).normalized()
	velocity = direction * CHASE_SPEED 
	if position.distance_to(player.position) < 100.0:
		charge_dir = Vector2.ZERO
		current_state = State.CHARGE
		wait_time = 0.2
	
func charge() -> void:
	velocity = charge_dir * CHARGE_SPEED
