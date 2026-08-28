extends MinigameManager

@onready var hands_container: Node2D = $Hands

signal game_success()
signal apple_state_changed(apple_id)
var hands_list: Array[Node]
var hands_timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	game_stats.progress_label.add_theme_font_size_override("normal_font_size", 24)
	game_stats.timer.add_theme_font_size_override("normal_font_size", 36)
	
	completed_points = total_points
	
	hands_list = hands_container.get_children()
	
	randomize()
	hands_timer = Timer.new()
	add_child(hands_timer)
	hands_timer.timeout.connect(grab_apple)
	start_hands_timer()
	
func _process(delta: float) -> void:
	# Overwrites minigame_manager
	game_stats.progress_label.text = "Protect all 7 apples!"
	
	if timer_end and not game_ended:
		game_ended = true
		game_stats.display_time = false
		game_success.emit()
		await game_stats.Timer(1.5)
		game_stats.display_time = true
		Global.minigame_done(true)

	elif completed_points < total_points and not game_ended:
		timer_end = false
		game_ended = true

		game_stats.progress_label.add_theme_color_override("default_color", Color.RED)
		
		GlobalAudio.stop_timer()
		await GlobalAudio.time_up()
		Global.minigame_done(false)
		
func start_hands_timer() -> void:
	hands_timer.start(randf_range(0.4, 1.0))

func grab_apple():
	start_hands_timer()
	
	var hand_num = randi_range(0, hands_list.size()-1)
	var new_num = hand_num
	for i in range(hands_list.size()):
		new_num = (hand_num + i) % hands_list.size()
		
		if hands_list[new_num].state == "inactive":
			hands_list[new_num].grab_apple()
			hands_list[new_num].state = "reaching"
			break
