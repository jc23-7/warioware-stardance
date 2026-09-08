extends MinigameManager

@onready var cassiopeia: Sprite2D = $Cassiopeia
@onready var ring: AnimatedSprite2D = $Ring

var lives = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	if Input.is_action_just_pressed("space_key"):
		if abs(wrapf(ring.rotation_degrees - cassiopeia.rotation_degrees, -180.0, 180.0)) <= ring.degrees[completed_points]:
			completed_points += 1
			print(completed_points)
			if completed_points != total_points:
				ring.next_ring(true)
		else:
			print(ring.rotation_degrees)
			print(cassiopeia.rotation_degrees)
			print(ring.degrees[completed_points])
			ring.next_ring(false)
			lives -= 1
			if lives == 0:
				end_game = true
