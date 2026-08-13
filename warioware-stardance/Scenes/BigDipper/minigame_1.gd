extends MinigameManager

@onready var star_container: Node2D = $"Player/Visuals/StarContainer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	for i in range(7):
		var child = star_container.get_child(i)
		child.visible = false
	
	
	var star_timer = Timer.new()
	star_timer.wait_time = 0.5
	star_timer.autostart = true
	add_child(star_timer)
	star_timer.timeout.connect(_spawn_star)


func _spawn_star():
	randomize()
	var star_template = preload("./collectable_mg1.tscn")
	var star = star_template.instantiate()
	
	star.collectable_collected.connect(_on_collectable_collected)
	
	add_child(star)
	star.position.y = -50
	star.position.x = randf_range(0+25, 470 - 10)


func _on_collectable_collected() -> void:
	if not game_ended:
		increase_point(1, GlobalAudio.collect_star)
