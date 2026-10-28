extends Sprite2D

@export var max_swing: float
@export var min_duration: float
@export var max_duration: float

var swing_tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	swing()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func swing() -> void:
	var target_angle = deg_to_rad(randf_range(-1 * max_swing, max_swing))
	var duration = randf_range(min_duration, max_duration)
	
	swing_tween = create_tween()
	swing_tween.set_trans(Tween.TRANS_SINE)
	swing_tween.set_ease(Tween.EASE_IN_OUT)
	
	swing_tween.tween_property(self, "rotation", target_angle, duration)
	swing_tween.finished.connect(swing)
	
