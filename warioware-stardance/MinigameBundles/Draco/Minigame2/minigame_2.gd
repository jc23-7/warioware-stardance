extends MinigameManager

@onready var dragons_container: Node2D = $Dragons
@onready var basket: AnimatedSprite2D = $Basket

signal game_success()
signal star_state_changed(star_id)
signal active_dragon_changed(start_id, end_id)

var dragons: Array[Node]
var active_dragon
var active_dragon_num
var has_star = false
var star_moving = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	dragons = dragons_container.get_children()
	active_dragon = dragons[0]
	active_dragon_num = 0
	
func _process(delta: float) -> void:
	super(delta)
	basket.frame = completed_points
	if Input.is_action_just_pressed("ui_up"):
		if not has_star:
			active_dragon.grab()
	elif Input.is_action_just_pressed("ui_right") and not star_moving:
		if active_dragon_num == 6:
			if has_star:
				has_star = false
				completed_points += 1
		else:
			if has_star:
				active_dragon_changed.emit(active_dragon_num, active_dragon_num + 1)
				star_moving = true
			else:
				change_active_dragon(active_dragon_num + 1)
	elif Input.is_action_just_pressed("ui_left") and not star_moving:
		if active_dragon_num == 0:
			if has_star:
				has_star = false
				completed_points += 1
		else:
			if has_star:
				active_dragon_changed.emit(active_dragon_num, active_dragon_num - 1)
				star_moving = true
			else:
				change_active_dragon(active_dragon_num - 1)

func change_active_dragon(new_dragon: int) -> void:
	star_moving = false
	active_dragon_num = new_dragon
	active_dragon = dragons[active_dragon_num]
