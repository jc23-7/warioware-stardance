extends Control

@onready var level: RichTextLabel = $VBoxContainer/Level
@onready var timer: RichTextLabel = $VBoxContainer/Timer

var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.lives == 0:
		Global.next_minigame()
	else:
		await Timer(1.0)
		Global.next_minigame()
	
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:			
	timer.text = "[center]" + str(time) + "[/center]"
	level.text = "[center]Level " + str(Global.minigames_done  + 1) + "[/center]"

func Timer(start_time: float):
	time = start_time
	GlobalAudio.start_timer(0, false)
	
	while time > 0.0:
		await wait(0.1)
		time -= 0.1
	
	GlobalAudio.stop_timer()

	return

func wait(seconds: float):
	await get_tree().create_timer(seconds).timeout
