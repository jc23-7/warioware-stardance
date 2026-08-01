extends Node

var fade_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	
func stop_all() -> void:
	for child in get_children():
		child.stop()
