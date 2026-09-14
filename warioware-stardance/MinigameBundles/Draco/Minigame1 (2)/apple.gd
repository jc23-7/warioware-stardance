extends AnimatedSprite2D

@onready var minigame: Node2D = $"../../"
var animation_playing = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = 1
	minigame.apple_state_changed.connect(_on_apple_state_changed)
	minigame.game_success.connect(play_animation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animation_playing != 0:
		print(animation_playing)
		print(floor(animation_playing/10))
		frame = floor(animation_playing / 10)
		animation_playing += 1
		if frame == 6:
			animation_playing = 0
	
func _on_apple_state_changed(id: int) -> void:
	if int(str(name)[-1]) == id:
		if frame == 1:
			frame = 0
		else:
			frame = 1

func play_animation() -> void:
	frame = 1
	animation_playing = 10

func _on_star_state_changed(id: int) -> void:
	if int(str(name)[-1]) == id:
		if frame > 6:
			frame = 9
		else:
			randomize()
			frame = randi_range(7, 8)
