extends MinigameManager

@export var min_time: float
@export var max_time: float

@onready var hands_container: Node2D = $Hands

signal game_success()
signal apple_state_changed(apple_id)
var hands_list: Array[Node]
var hands_timer
var hands_defeated = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	if not Global.tutorial:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
		
		
		randomize()
		hands_timer = Timer.new()
		add_child(hands_timer)
		hands_timer.timeout.connect(grab_apple)
		start_hands_timer()
		
	hands_list = hands_container.get_children()

	
func _process(delta: float) -> void:
	super(delta)
	
func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func start_hands_timer() -> void:
	hands_timer.start(randf_range(min_time, max_time))

func grab_apple(hand_id: int = 0):
	if not Global.tutorial:
		start_hands_timer()
		var hand_num = randi_range(0, hands_list.size()-1)
	
		var new_num = hand_num
		for i in range(hands_list.size()):
			new_num = (hand_num + i) % hands_list.size()
			if not hands_list[new_num].active:
				hands_list[new_num].grab()
				hands_list[new_num].active = true
				break
	else:
		if not is_node_ready():
			await ready
		hands_list[hand_id].grab()
		hands_list[hand_id].active = true
		
