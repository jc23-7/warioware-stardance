extends Node2D
@onready var timer: RichTextLabel = $VBoxContainer/Timer
@onready var parent = $".."

var display_time = true
var time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if display_time:
		timer.text = str(snapped(max(0.0, time), 0.10))
	
func Timer(start_time: float):
	
	time = start_time
	GlobalAudio.start_timer(-5, true)
	while time > 0.0:
		await wait(0.10)
		time -= 0.1
	GlobalAudio.stop_timer()
		
	return
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
