extends Node2D

@onready var game_timer: Node2D = $GameTimer
@onready var star_bucket_animation: AnimatedSprite2D = $"StarBucket/Animation"

var stars_hung = 0
var star_picked_up = false
var timer_end = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await game_timer.Timer(20.0)
	timer_end = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stars_hung == 7:
		if Global.minigames_done > 3:
			Global.change_scene("res://scenes/end_screen.tscn")
		else:
			Global.change_scene("res://Scenes/timer_screen.tscn")
			
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -= 1
		Global.change_scene("res://Scenes/timer_screen.tscn")


func _on_star_picked_up(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not star_picked_up:
			star_picked_up = true
			var star_template = preload("res://Scenes/star_mg2.tscn")
			var star = star_template.instantiate()
			
			Global.star_spot_clicked.connect(star._on_star_spot_clicked)
			
			add_child(star)
			
			star_bucket_animation.frame = stars_hung + 1

	
