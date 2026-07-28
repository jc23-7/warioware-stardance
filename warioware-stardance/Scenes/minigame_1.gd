extends Node2D
@onready var game_timer: Node2D = $GameTimer
@onready var progress_label: RichTextLabel = $GameTimer/VBoxContainer/Progress
@onready var star_container: Node2D = $"Player/Visuals/StarContainer"

var num_collected = 0
var timer_end = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:		
	for i in range(7):
		var child = star_container.get_child(i)
		child.visible = false
	
	
	var star_timer = Timer.new()
	star_timer.wait_time = 0.5
	star_timer.autostart = true
	add_child(star_timer)
	star_timer.timeout.connect(_spawn_star)

	await game_timer.Timer(10.0)
	timer_end = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_label.text = str(num_collected) + "/7"
	
	if num_collected >= 7:
		await game_timer.Timer(0.5)
		if Global.minigames_done > 3:
			Global.change_scene("res://scenes/end_screen.tscn")
		else:
			Global.change_scene("res://Scenes/timer_screen.tscn")
		
		
			
	if timer_end:
		Global.minigames_done -= 1
		Global.lives -= 1
		Global.change_scene("res://Scenes/timer_screen.tscn")
		

func _spawn_star():
	randomize()
	var star_template = preload("res://Scenes/collectable_mg1.tscn")
	var star = star_template.instantiate()
	
	star.collectable_collected.connect(_on_collectable_collected)
	
	add_child(star)
	star.position.y = -50
	star.position.x = randf_range(0+50, 940 - 20)


func _on_collectable_collected() -> void:
	var star = star_container.get_child(num_collected)
	star.visible = true
	num_collected += 1
	return
