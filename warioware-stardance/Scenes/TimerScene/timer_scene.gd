extends Control

@onready var survival_container: Control = $Survival
@onready var play_container: Control = $Play

var level: RichTextLabel
var timer: RichTextLabel

var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if Global.current_mode == Global.Mode.PLAY:
		play_container.show()
		survival_container.hide()
		
		level = $Play/CenterContainer/VBoxContainer/Level
		timer = $Play/CenterContainer/VBoxContainer/Timer
		
		level.text = Global.current_constellation.constellation_name
		
		for child in $Play/Constellations.get_children():
			if str(child.name) == Global.current_constellation.constellation_name:
				child.show()
			else:
				child.hide()
		
	elif Global.current_mode == Global.Mode.SURVIVAL: 
		play_container.hide()
		survival_container.show()
		
		level = $Survival/VBoxContainer/Level
		timer = $Survival/VBoxContainer/Timer
		
		level.text = "Level " + str(Global.minigames_done  + 1)

	
	await Timer(1.0)
	Global.next_minigame()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.text = str(time)

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
