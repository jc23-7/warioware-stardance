extends Node2D

@onready var mute_button: TextureButton = $"CanvasLayer/MuteButton"

var fade_tween: Tween
var bgm_fade: Tween
var mute = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mute_button.button_pressed = false
	reset_bgm()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not $BGM.playing:
		reset_bgm()
	if Input.is_action_just_released("mute"):
		if mute:
			mute_button.button_pressed = false
		else:
			mute_button.button_pressed = true
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
	if not Global.tutorial:
		$CollectStar.play()

func shine() -> void:
	if not Global.tutorial:
		$Shine.play()
	
func ding() -> void:
	if not Global.tutorial:
		$Ding.play()
	
func start_timer(vol: int, fade_in: bool) -> void:
	if not Global.tutorial:
		if fade_tween and fade_tween.is_valid():
			fade_tween.kill()
		$Timer.volume_db = vol
		$Timer.play()
		if fade_in:
			$Timer.volume_db = -20
			fade_tween = create_tween()
			fade_tween.tween_property($Timer, "volume_db", vol, 2.0)

		
func stop_timer() -> void:
	if not Global.tutorial:
		$Timer.stop()
	
func time_up() -> void:
	if not Global.tutorial:
		$TimeUp.play()
		await $TimeUp.finished

func success() -> void:
	if not Global.tutorial:
		$CollectStar.play()
		await $CollectStar.finished

func _on_mute_button_pressed() -> void:
	if mute:
		mute_button.button_pressed = false
	else:
		mute_button.button_pressed = true
	mute = not mute
	var master_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_index, mute)
