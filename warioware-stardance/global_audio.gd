extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func button_pressed() -> void:
	$ButtonClick.play()
	
func collect_star() -> void:
	$CollectStar.play()

func shine() -> void:
	$Shine.play()
	
func ding() -> void:
	$Ding.play()
	
func start_timer() -> void:
	$Timer.play()

func stop_timer() -> void:
	$Timer.stop()
