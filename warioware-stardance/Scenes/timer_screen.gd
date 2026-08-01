extends Control

@onready var level: RichTextLabel = $VBoxContainer/Level
@onready var timer: RichTextLabel = $VBoxContainer/Timer

var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#level.global_position.x = (get_viewport_rect().size.x - level.size.x)/ 2
	#timer.global_position.x = (get_viewport_rect().size.x - timer.size.x) / 2
	#
	if Global.lives == 0:
		Global.change_scene("res://Scenes/end_screen.tscn")
	else:
		await Timer(1.0)
		
		Global.minigames_done += 1
		Global.change_scene("res://scenes/minigame_" + str(Global.minigames_done) + ".tscn")
	
		
	


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

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
