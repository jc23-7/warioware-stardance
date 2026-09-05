extends AnimatedSprite2D

@export var degrees: Array[float]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	pass
		


func next_ring(success: bool) -> void:
	if success:
		frame += 1
	randomize()
	rotation_degrees = randf_range(0, 360)
