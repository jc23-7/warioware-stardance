extends Marker2D

@export var obstacles: Array[PackedScene]
@export var min_time: float
@export var max_time: float

var cur_obstacle
var timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	spawn_obstacle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if not timer and cur_obstacle and cur_obstacle.can_spawn_next:
		timer = Timer.new()
		add_child(timer)
		timer.start(randf_range(min_time, max_time))
		timer.timeout.connect(spawn_obstacle)

func spawn_obstacle():
	if timer:
		timer.queue_free()
		timer = null
	
	randomize()
	cur_obstacle = obstacles[randi_range(0, obstacles.size() - 1)].instantiate()
	cur_obstacle.global_position.y = randi_range(cur_obstacle.min_y, cur_obstacle.max_y)
	add_child(cur_obstacle)
	
	
