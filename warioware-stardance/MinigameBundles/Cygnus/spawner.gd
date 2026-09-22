extends Marker2D

@export var obstacles: Array[PackedScene]
@export var min_time: float
@export var max_time: float

var cur_obstacle
var timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	if not Global.tutorial:
		spawn_obstacle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Global.tutorial:
		if not timer and cur_obstacle and cur_obstacle.can_spawn_next:
			timer = Timer.new()
			add_child(timer)
			timer.start(randf_range(min_time, max_time))
			timer.timeout.connect(spawn_obstacle)
	else:
		if not cur_obstacle:
			cur_obstacle = obstacles[0].instantiate()
			add_child(cur_obstacle)
			#cur_obstacle.global_position.y = 0
			#
			

func spawn_obstacle():
	if timer:
		timer.queue_free()
		timer = null

	cur_obstacle = obstacles[randi_range(0, obstacles.size() - 1)].instantiate()
	add_child(cur_obstacle)
	cur_obstacle.global_position = Vector2(get_viewport_rect().size.x + cur_obstacle.width, randf_range(cur_obstacle.min_y, cur_obstacle.max_y))
	
	
	
	
