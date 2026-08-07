extends Node2D

@onready var mute_animated_sprite: AnimatedSprite2D = $"MuteButton/AnimatedSprite2D"

var fade_tween: Tween
var bgm_fade: Tween
var tutorial = false
var mute = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mute_animated_sprite.frame = 0
	reset_bgm()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not $BGM.playing:
		reset_bgm()
	if Input.is_action_just_released("mute"):
		if mute:
			mute_animated_sprite.frame = 0
		else:
			mute_animated_sprite.frame = 1
		mute = not mute
		var master_index = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(master_index, mute)
		
func reset_bgm() -> void:
	if bgm_fade and bgm_fade.is_valid():
		bgm_fade.kill()
	$BGM.volume_db = -50
	$BGM.play()
	bgm_fade = create_tween()
	bgm_fade.tween_property($BGM, "volume_db", -10, 10.0)

func button_pressed() -> void:
	$ButtonClick.play()
	
func collect_star() -> void:
	if not tutorial:
		$CollectStar.play()

func shine() -> void:
	if not tutorial:
		$Shine.play()
	
func ding() -> void:
	if not tutorial:
		$Ding.play()
	
func start_timer(vol: int, fade_in: bool) -> void:
	if not tutorial:
		if fade_tween and fade_tween.is_valid():
			fade_tween.kill()
		$Timer.volume_db = vol
		$Timer.play()
		if fade_in:
			$Timer.volume_db = -20
			fade_tween = create_tween()
			fade_tween.tween_property($Timer, "volume_db", vol, 2.0)

		
func stop_timer() -> void:
	if not tutorial:
		$Timer.stop()
	
func time_up() -> void:
	if not tutorial:
		$TimeUp.play()
		await $TimeUp.finished

func _button_clicked(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if mute:
			mute_animated_sprite.frame = 0
		else:
			mute_animated_sprite.frame = 1
		mute = not mute
		var master_index = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(master_index, mute)
