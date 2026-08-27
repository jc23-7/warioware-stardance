extends AnimatedSprite2D

@onready var minigame_1: Node2D = $"../../"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	minigame_1.apple_state_changed.connect(_on_apple_state_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_apple_state_changed(id: int) -> void:
	if int(str(name)[-1]) == id:
		if frame == 1:
			frame = 0
		else:
			frame = 1
