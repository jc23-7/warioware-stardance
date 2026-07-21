extends Node2D
@onready var heart_container: HBoxContainer = $HeartContainer
@onready var heart_1: TextureRect = $HeartContainer/Heart1
@onready var heart_2: TextureRect = $HeartContainer/Heart2
@onready var heart_3: TextureRect = $HeartContainer/Heart3
@onready var heart_4: TextureRect = $HeartContainer/Heart4
@onready var heart_5: TextureRect = $HeartContainer/Heart5
@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer

var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Timer(5.0)
	
	if Global.minigames_done < 3:
		Global.minigames_done += 1
		get_tree().change_scene_to_file("res://scenes/minigame_" + str(Global.minigames_done) + ".tscn")
		
	else:
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match Global.lives:
		4: 
			heart_1.hide()
		3:
			heart_1.hide()
			heart_2.hide()
		2:
			heart_1.hide()
			heart_2.hide()
			heart_3.hide()
		1:
			heart_1.hide()
			heart_2.hide()
			heart_3.hide()
		0:
			heart_container.hide()
			
	timer.text = str(time)
	level.text = "Level" + str(Global.minigames_done)

func Timer(start_time: float):
	time = start_time
	
	while time > 0.0:
		await wait(0.1)
		time -= 0.1
	return

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
