extends Node

@export var constellations: Array[Constellation]
@export var title_scene: PackedScene
@export var timer_scene: PackedScene
@export var end_scene: PackedScene
@export var level_select: PackedScene

var mode
var tutorial = false
var minigames_done = 0
var total_minigames = 3
var lives = 5

var current_constellation: Constellation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset_game() -> void:
	minigames_done = 0
	total_minigames = 3
	lives = 5

func change_scene(next_scene_name: String) -> void:
	if next_scene_name == "title_scene":
		get_tree().change_scene_to_packed(title_scene)
		reset_game()
	elif next_scene_name == "level_select":
		get_tree().change_scene_to_packed(level_select)


func start_constellation(constellation: Constellation) -> void:
	current_constellation = constellation
	minigames_done = 0
	get_tree().change_scene_to_packed(timer_scene)

func start_survival() -> void:
	reset_game()
	get_tree().change_scene_to_packed(timer_scene)

func next_minigame() -> void:
	randomize()
	get_tree().change_scene_to_packed(constellations[randi_range(0, constellations.size() - 1)].minigame)
	
	
func minigame_done(success: bool) -> void:
	if mode == "Play":
		constellations[constellations.find(current_constellation)].completed = success
		get_tree().change_scene_to_packed(level_select)
	elif mode == "Survival":
		if success:
			minigames_done += 1
		else:
			lives -= 1

		if lives == 0:
			get_tree().change_scene_to_packed(end_scene)
		else:
			get_tree().change_scene_to_packed(timer_scene)
