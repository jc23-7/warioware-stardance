extends CharacterBody2D

@onready var parent_minigame = $"../"
@onready var player = $"../Player"

const CHASE_SPEED = 100.0
const CHARGE_SPEED = 500.0

enum State {CHASE, CHARGE, RECOVER}
var current_state = State.CHASE
var charge_dir = Vector2.ZERO
var wait_time := 0.0
var touching_player = false

func _physics_process(delta: float) -> void:
	if parent_minigame.game_ended:
		velocity = Vector2.ZERO
	else:
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
			var touched_player = false
			for i in range(get_slide_collision_count()):
				var collision = get_slide_collision(i)
				if collision.get_collider() is CharacterBody2D:
					touched_player = true
				current_state = State.RECOVER
				wait_time = 2.0
			if touching_player and not touched_player:
				touching_player = false
			elif touched_player and not touching_player:
				parent_minigame.lives -= 1

func chase() -> void:
	var direction = position.direction_to(player.position).normalized()
	velocity = direction * CHASE_SPEED 
	if position.distance_to(player.position) < 100.0:
		charge_dir = Vector2.ZERO
		current_state = State.CHARGE
		wait_time = 0.2
	
func charge() -> void:
	velocity = charge_dir * CHARGE_SPEED
