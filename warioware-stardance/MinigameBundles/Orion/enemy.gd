extends CharacterBody2D

@onready var parent_minigame = $"../"
@onready var player = $"../Player"
@onready var animated_sprite = $AnimatedSprite2D

const CHASE_SPEED = 100.0
const CHARGE_SPEED = 450.0

enum State {CHASE, CHARGE, RECOVER, ATTACK}
var current_state = State.RECOVER
var charge_dir = Vector2.ZERO
var wait_time := 1.0
var touching_player = false

func _ready() -> void:
	animated_sprite.animation_finished.connect(_on_animation_finished)
	look_at(player.position)

func _physics_process(delta: float) -> void:
	if parent_minigame.game_ended:
		velocity = Vector2.ZERO
	else:
		if current_state == State.ATTACK:
			velocity = Vector2.ZERO
		else:
			if current_state == State.CHASE:
				animated_sprite.play("default")
				chase()
			elif current_state == State.CHARGE:
				animated_sprite.play("default")
				if wait_time <= 0:
					if charge_dir == Vector2.ZERO:
						charge_dir = position.direction_to(player.position).normalized()
					charge()
				else:
					wait_time -= delta
					velocity = Vector2.ZERO
			elif current_state == State.RECOVER:
				animated_sprite.play("default")
				animated_sprite.frame = 1
				velocity = Vector2.ZERO
				wait_time -= delta
				if wait_time <= 0:
					current_state = State.CHASE
			
		move_and_slide()
		
		if current_state == State.CHARGE:
			var touched_player = false
			for i in range(get_slide_collision_count()):
				var collision = get_slide_collision(i)
				current_state = State.ATTACK
				animated_sprite.play("attack")
				if collision.get_collider() is CharacterBody2D:
					touched_player = true
				wait_time = 2.0
			if touching_player and not touched_player:
				touching_player = false
			elif touched_player and not touching_player:
				if current_state == State.ATTACK:
					player.lose_life()
					

func chase() -> void:
	look_at(player.position)
	var direction = position.direction_to(player.position).normalized()
	velocity = direction * CHASE_SPEED 
	if position.distance_to(player.position) < 200.0:
		charge_dir = Vector2.ZERO
		current_state = State.CHARGE
		wait_time = 0.2
		
	
func charge() -> void:
	velocity = charge_dir * CHARGE_SPEED
	
func _on_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		current_state = State.RECOVER
		
