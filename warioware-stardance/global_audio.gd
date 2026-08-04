extends Node

var fade_tween: Tween
var bgm_fade: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_bgm()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not $BGM.playing:
		reset_bgm()
		
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
	$CollectStar.play()

func shine() -> void:
	$Shine.play()
	
func ding() -> void:
	$Ding.play()
	
func start_timer(vol: int, fade_in: bool) -> void:
	if fade_tween and fade_tween.is_valid():
		fade_tween.kill()
	$Timer.volume_db = vol
	$Timer.play()
	if fade_in:
		$Timer.volume_db = -20
		fade_tween = create_tween()
		fade_tween.tween_property($Timer, "volume_db", vol, 2.0)

		
func stop_timer() -> void:
	$Timer.stop()
	
func time_up() -> void:
	$TimeUp.play()
	await $TimeUp.finished
	
