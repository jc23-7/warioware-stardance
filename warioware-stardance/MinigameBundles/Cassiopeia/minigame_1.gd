extends MinigameManager

@onready var cassiopeia: Sprite2D = $Cassiopeia
@onready var ring: AnimatedSprite2D = $Ring

var tutorial_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	if Global.tutorial:
		tutorial_timer += delta
		if abs(wrapf(ring.rotation_degrees - cassiopeia.rotation_degrees, -180.0, 180.0)) <= ring.degrees[completed_points] and tutorial_timer > 1.0:
			tutorial_timer = 0.0
			randomize()
			if randi_range(0, 1) == 0:
				completed_points += 1
				if completed_points != total_points:
					ring.next_ring(true)
	else:
		if Input.is_action_just_pressed("space_key"):
			if abs(wrapf(ring.rotation_degrees - cassiopeia.rotation_degrees, -180.0, 180.0)) <= ring.degrees[completed_points]:
				completed_points += 1
				if completed_points != total_points:
					ring.next_ring(true)
			else:
				ring.next_ring(false)
				lives -= 1
