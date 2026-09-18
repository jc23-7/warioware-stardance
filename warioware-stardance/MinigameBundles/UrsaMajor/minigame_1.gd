extends MinigameManager

@export var arrow_template: PackedScene
@export var arrow_vert_min_speed: float
@export var arrow_vert_max_speed: float
@export var arrow_hor_min_speed: float
@export var arrow_hor_max_speed: float
@export var min_time: float
@export var max_time: float

@onready var player: CharacterBody2D = $Bear

var arrow_timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	randomize()
	
	arrow_timer = Timer.new()
	add_child(arrow_timer)
	arrow_timer.timeout.connect(spawn_arrow)
	arrow_timer.start(randf_range(min_time, max_time))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func spawn_arrow() -> void:
	var arrow = arrow_template.instantiate()
	arrow.vertical_speed = randf_range(arrow_vert_min_speed, arrow_vert_max_speed)
	arrow.horizontal_speed = randf_range(arrow_hor_min_speed, arrow_hor_max_speed)
	arrow.parent_minigame = $"./"
	arrow.player = player
	arrow.min_hit_y = 225
	add_child(arrow)
	arrow_timer.start(randf_range(min_time, max_time))
