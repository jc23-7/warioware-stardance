extends Node2D
class_name MinigameManager
@export var game_stats: Node2D
@export var total_points: int
@export var time_limit: float
@export var increase_points: bool
@export var activate_timer: bool
@export var show_points: bool

var completed_points = 0
var timer_end = false
var game_ended = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not increase_points:
		completed_points = total_points
	if activate_timer:
		await game_stats.Timer(time_limit)
		timer_end = true
	else:
		game_stats.timer.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if show_points:
		game_stats.progress_label.text = str(completed_points) + "/" + str(total_points)
	else:
		game_stats.progress_label.text = " "
	if increase_points:
		
		if completed_points >= total_points and not game_ended:
			game_stats.display_time = false
			await game_stats.Timer(0.5)
			game_stats.display_time = true
			Global.minigame_done(true)

		elif timer_end and not game_ended:
			timer_end = false
			game_ended = true

			game_stats.timer.add_theme_color_override("default_color", Color.RED)
			game_stats.progress_label.add_theme_color_override("default_color", Color.RED)
			
			GlobalAudio.stop_timer()
			await GlobalAudio.time_up()
			Global.minigame_done(false)
	else:
		if timer_end and not game_ended:
			game_stats.display_time = false
			await game_stats.Timer(0.5)
			game_stats.display_time = true
			Global.minigame_done(true)

		elif completed_points <= 0 and not game_ended:
			timer_end = false
			game_ended = true

			game_stats.timer.add_theme_color_override("default_color", Color.RED)
			game_stats.progress_label.add_theme_color_override("default_color", Color.RED)
			
			GlobalAudio.stop_timer()
			await GlobalAudio.time_up()
			Global.minigame_done(false)
		


func increase_point(num_increase: int, sound_played: Callable) -> void:
	if completed_points < total_points and not game_ended:
		completed_points = min(total_points, completed_points + num_increase)
		sound_played.call()
