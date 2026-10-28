extends Node2D

@onready var parent = $".."

var info_container: Node2D

var display_time
var display_progress
var display_lives

var timer_label: RichTextLabel
var progress_label: RichTextLabel
var hearts: Node2D

var time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_time = parent.display_time
	display_progress = parent.display_progress
	display_lives = parent.display_lives
	if display_time and display_progress and display_lives:
		info_container = $All
		for child in info_container.get_children():
			if child is VBoxContainer:
				for label in child.get_children():
					if label.name == "Progress":
						progress_label = label
					else:
						timer_label = label
			else:
				hearts = child
	elif display_time and display_lives:
		info_container = $HeartTimer
		for child in info_container.get_children():
			if child is RichTextLabel:
				timer_label = child
			else:
				hearts = child
	elif display_lives and display_progress:
		info_container = $HeartProgress
		for child in info_container.get_children():
			if child is RichTextLabel:
				progress_label = child
			else:
				hearts = child
	elif display_progress and display_time:
		info_container = $ProgressTimer
		for child in info_container.get_children():
			for label in child:
				if child.name == "Progress":
					progress_label = label
				else:
					timer_label = label
	for child in get_children():
		if child == info_container:
			child.show()
		else:
			child.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if display_time and not parent.game_ended:
		timer_label.text = str(snapped(max(0.0, time), 0.10))
	if display_progress:
		progress_label.text = str(parent.completed_points) + "/" + str(parent.total_points)
	if parent.game_ended:
		if not parent.success:
			if display_time:
				timer_label.add_theme_color_override("default_color", Color.RED)
			if display_progress:
				progress_label.add_theme_color_override("default_color", Color.RED)
	
func Timer(start_time: float):
	
	time = start_time
	GlobalAudio.start_timer(-5, true)
	while time > 0.0:
		await wait(0.10)
		time -= 0.1
	GlobalAudio.stop_timer()
		
	return
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
