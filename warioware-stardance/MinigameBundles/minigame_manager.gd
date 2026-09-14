extends Node2D
class_name MinigameManager
@export var game_stats: Node2D
@export var total_points: int
@export var lives: int
@export var time_limit: float

@export var display_time: bool
@export var display_progress: bool
@export var display_lives: bool

var completed_points = 0
var game_ended = false
var success

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if display_time:
		await game_stats.Timer(time_limit)
		game_ended = true
		if display_lives:
			_on_game_success()
		else:
			_on_game_fail()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if display_lives and lives <= 0 and not game_ended:
		game_ended = true
		_on_game_fail()
	elif display_progress and completed_points >= total_points and not game_ended:
		game_ended = true
		_on_game_success()

func _on_game_success() -> void:
	success = true
	await game_stats.Timer(1.5)
	Global.minigame_done(true)
	
func _on_game_fail() -> void:
	success = false
	GlobalAudio.stop_timer()
	await GlobalAudio.time_up()
	Global.minigame_done(false)

func increase_point(num_increase: int, sound_played: Callable) -> void:
	if completed_points < total_points and not game_ended:
		completed_points = min(total_points, completed_points + num_increase)
		sound_played.call()
